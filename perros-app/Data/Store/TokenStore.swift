//
//  TokenStore.swift
//  perros-app
//
//  Created by Alan Steiman on 12/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import Foundation
import KeychainAccess

protocol TokenStorage {
    var token: String? { get }

    func setToken(token: String)
    func revoke()
}

final class TokenStore: TokenStorage, ObservableObject {
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
