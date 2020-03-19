//
//  DashboardRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 19/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

protocol DashboardRepository: WebRepository {
    func getOrders() -> AnyPublisher<[OrdersDashboard], GenericError>
}

struct RealDashboardRepository: DashboardRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let tokenStore: TokenStore
        
    init(session: URLSession, baseURL: String, tokenStore: TokenStore) {
        self.session = session
        self.baseURL = baseURL
        self.tokenStore = tokenStore
    }
    
    func getOrders() -> AnyPublisher<[OrdersDashboard], GenericError> {
        return call(endpoint: API.all)
            .mapError { error in
            return GenericError.network
        }.eraseToAnyPublisher()
    }
}

// MARK: - Endpoints

extension RealDashboardRepository {
    enum API {
        case all
    }
}

extension RealDashboardRepository.API: APICall {
    var needsToken: Bool {
        true
    }
    
    var path: String {
        switch self {
        case .all:
            return "/dashboard"
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
