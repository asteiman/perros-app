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
    func getOrders(customerId: Customer.ID) -> AnyPublisher<[Order], GenericError>
    func getBilling(customerId: Customer.ID) -> AnyPublisher<[Billing], GenericError>
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
    
    func getOrders(customerId: Customer.ID) -> AnyPublisher<[Order], GenericError> {
        return call(endpoint: API.orders(customerId: customerId))
            .mapError { error in
            return GenericError.network
        }.eraseToAnyPublisher()
    }
    
    func getBilling(customerId: Customer.ID) -> AnyPublisher<[Billing], GenericError> {
        return call(endpoint: API.billing(customerId: customerId))
            .mapError { error in
            return GenericError.network
        }.eraseToAnyPublisher()
    }
}

// MARK: - Endpoints

extension RealCustomerRepository {
    enum API {
        case all
        case orders(customerId: Customer.ID)
        case billing(customerId: Customer.ID)
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
        case .orders(let customerId):
            return "/customers/\(customerId)/invoices"
        case .billing(let customerId):
            return "/customers/\(customerId)/billings"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String]? {
        let headers = ["Accept": "application/json"]
        
        return headers
    }
    
    func body() throws -> Data? {
        return nil
    }
}
