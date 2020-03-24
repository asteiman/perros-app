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
        return "foo"
    }()
    
    func setToken(token: String) {
        
    }
    
    func revoke() {
        
    }
}
