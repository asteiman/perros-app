//
//  MockTokenStore.swift
//  perros-appTests
//
//  Created by Alan Steiman on 24/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
@testable import perros_app

final class MockTokenStore: TokenStorage {
    var token: String? = {
        "foo"
    }()

    func setToken(token: String) {
        self.token = token
    }

    func revoke() {
        token = nil
    }
}
