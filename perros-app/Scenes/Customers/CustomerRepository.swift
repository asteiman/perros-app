//
//  CustomerRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import Foundation

protocol CustomerRepository: WebRepository {
    func getAll() -> AnyPublisher<[Customer], Error>
}

struct RealCustomerRepository: CustomerRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getAll() -> AnyPublisher<[Customer], Error> {
        return call(endpoint: API.all)
    }
}

// MARK: - Endpoints

extension RealCustomerRepository {
    enum API {
        case all
    }
}

extension RealCustomerRepository.API: APICall {
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
