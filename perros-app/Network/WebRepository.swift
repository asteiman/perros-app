//
//  WebRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 10/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
    var tokenStore: TokenStorage { get }
}

extension WebRepository {
    func call<T: Decodable>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<T, APIError> {
        guard var request = try? endpoint.urlRequest(baseURL: baseURL) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        if endpoint.needsToken {
            guard let token = tokenStore.token else {
                tokenStore.revoke()
                return Fail(error: APIError.tokenNeeded).eraseToAnyPublisher()
            }
            request.allHTTPHeaderFields?["Authorization"] = "Bearer \(token)"
        }
        
        return session.dataTaskPublisher(for: request)
            .requestJSON(httpCodes: httpCodes)
            .mapError{ error in
                if case APIError.httpCode(401) = error {
                    self.tokenStore.revoke()
                }
                return error
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<T: Decodable>(httpCodes: HTTPCodes) -> AnyPublisher<T, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return tryMap {
                assert(!Thread.isMainThread)
                guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                    throw APIError.unexpectedResponse
                }
                guard httpCodes.contains(code) else {
                    throw APIError.httpCode(code)
                }
                return $0.0
            }
            .decode(type: T.self, decoder: decoder)
            .mapError{ error -> APIError in
                guard let apiError = error as? APIError else {
                    return .unexpectedResponse
                }
                return apiError
            }
            .eraseToAnyPublisher()
    }
}

private extension Publisher {
    
    /// Holds the downstream delivery of output until the specified time interval passed after the subscription
    /// Does not hold the output if it arrives later than the time threshold
    ///
    /// - Parameters:
    ///   - interval: The minimum time interval that should elapse after the subscription.
    /// - Returns: A publisher that optionally delays delivery of elements to the downstream receiver.
    
    func ensureTimeSpan(_ interval: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .seconds(interval), scheduler: RunLoop.main)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
}
