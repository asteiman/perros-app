//
//  CustomerRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

protocol CustomerRepository: WebRepository {
    func getAll() -> AnyPublisher<[Customer], GenericError>
}

struct RealCustomerRepository: CustomerRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let tokenStore: TokenStore
        
    init(session: URLSession, baseURL: String, tokenStore: TokenStore) {
        self.session = session
        self.baseURL = baseURL
        self.tokenStore = tokenStore
    }
    
    func getAll() -> AnyPublisher<[Customer], GenericError> {
        return call(endpoint: API.all)
            .mapError { error in
            return GenericError.network
        }.eraseToAnyPublisher()
    }
}

// MARK: - Endpoints

extension RealCustomerRepository {
    enum API {
        case all
    }
}

extension RealCustomerRepository.API: APICall {
    var needsToken: Bool {
        true
    }
    
    var path: String {
        switch self {
        case .all:
            return "/customers"
        }
    }
    
    var method: String {
        switch self {
        case .all:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        let headers = ["Accept": "application/json"]
        
        return headers
    }
    
    func body() throws -> Data? {
        return nil
    }
}
