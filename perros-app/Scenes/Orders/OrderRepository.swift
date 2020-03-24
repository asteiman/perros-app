//
//  OrderRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine

protocol OrderRepository: WebRepository {
    func getBy(customerId: Customer.ID) -> AnyPublisher<[Order], GenericError>
}

struct RealOrderRepository: OrderRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let tokenStore: TokenStorage
        
    init(session: URLSession, baseURL: String, tokenStore: TokenStorage) {
        self.session = session
        self.baseURL = baseURL
        self.tokenStore = tokenStore
    }
    
    func getBy(customerId: Customer.ID) -> AnyPublisher<[Order], GenericError> {
        return call(endpoint: API.all)
            .mapError { error in
            return GenericError.network
        }.eraseToAnyPublisher()
    }
}

// MARK: - Endpoints

extension RealOrderRepository {
    enum API {
        case all
    }
}

extension RealOrderRepository.API: APICall {
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
