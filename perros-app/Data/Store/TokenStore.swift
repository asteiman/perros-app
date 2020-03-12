//
//  TokenStore.swift
//  perros-app
//
//  Created by Alan Steiman on 12/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import KeychainAccess
import Combine

final class TokenStore: ObservableObject {
    let tokenSubject = PassthroughSubject<Void, Never>()

    private(set) var token: String?

    private let keychain = Keychain(service: "com.perros")
    
    func load() {
        token = keychain["token"]
        tokenSubject.send(())
    }
    
    func setToken(token: String) {
        self.token = token
        keychain["token"] = token
        tokenSubject.send(())
    }
    
    func revoke() {
        token = nil
        keychain["token"] = nil
        tokenSubject.send(())
    }
}
