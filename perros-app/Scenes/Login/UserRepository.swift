//
//  UserRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 10/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import Foundation

protocol UserRepository: WebRepository {
    func login(username: String, password: String) -> AnyPublisher<Void, Error>
    func logout()
}

struct RealUserRepository: UserRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    let appState: AppState
    
    init(session: URLSession, baseURL: String, appState: AppState) {
        self.session = session
        self.baseURL = baseURL
        self.appState = appState
    }
    
    func login(username: String, password: String) -> AnyPublisher<Void, Error> {
        let response: AnyPublisher<LoginResponse, Error> = call(endpoint: API.login(username: username, password: password))
        
        return response.map { response in
            self.appState.userToken = response.token
        }.eraseToAnyPublisher()
    }
    
    func logout() {
        appState.userToken = nil
    }
}

// MARK: - Endpoints

extension RealUserRepository {
    enum API {
        case login(username: String, password: String)
    }
}

extension RealUserRepository.API: APICall {
    var path: String {
        switch self {
        case .login(username: _, password: _):
            return "/login"
        }
    }
    
    var method: String {
        switch self {
        case .login(username: _, password: _):
            return "POST"
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Accept": "application/json"]
        
        switch self {
        case .login(let username, let password):
            
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            headers["Authorization"] = "Basic \(base64LoginString)"
        }
        
        return headers
    }
    
    func body() throws -> Data? {
        return nil
    }
}

struct LoginResponse: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "string"
    }
}
