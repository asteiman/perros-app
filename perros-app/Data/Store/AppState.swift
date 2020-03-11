//
//  AppState.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine
import KeychainAccess

final class AppState: ObservableObject {
    private let keychain = Keychain(service: "com.perros")
    var userToken: String? {
        didSet {
            keychain["token"] = userToken
            isLoggedIn = userToken != nil
        }
    }
    
    @Published var isLoggedIn: Bool = false
    
    init() {
        readToken()
    }
    
    private func readToken() {
        userToken = keychain["token"]
    }
}
