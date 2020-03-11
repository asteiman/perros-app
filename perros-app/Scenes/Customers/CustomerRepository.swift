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
    let appState: AppState
    
    init(session: URLSession, baseURL: String, appState: AppState) {
        self.session = session
        self.baseURL = baseURL
        self.appState = appState
    }
    
    func getAll() -> AnyPublisher<[Customer], Error> {
        return call(endpoint: API.all(token: appState.userToken))
    }
}

// MARK: - Endpoints

extension RealCustomerRepository {
    enum API {
        case all(token: String?)
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
        var headers = ["Accept": "application/json"]
        
        switch self {
        case .all(let token):
            if let token = token {
                headers["Authorization"] = "Bearer \(token)"
            }
        }
        
        return headers
    }
    
    func body() throws -> Data? {
        return nil
    }
}
