//
//  APICall.swift
//  perros-app
//
//  Created by Alan Steiman on 10/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
    var needsToken: Bool { get }
}

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case tokenNeeded
}

enum GenericError: Error {
    case network
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .tokenNeeded: return "Access token is required"
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
