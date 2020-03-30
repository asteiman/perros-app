//
//  TokenStoreTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 30/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
@testable import perros_app

class TokenStoreTests: XCTestCase {
    
    let sut = TokenStore()
    
    override func tearDown() {
        sut.revoke()
        super.tearDown()
    }
    
    func test_tokenStartsEmpty() {
        XCTAssertNil(sut.token)
    }
    
    func test_setToken_success() {
        sut.setToken(token: "foo")
        XCTAssertEqual("foo", sut.token)
    }
    
    func test_revoke_success() {
        sut.setToken(token: "foo")
        XCTAssertEqual("foo", sut.token)
        sut.revoke()
        XCTAssertNil(sut.token)
    }
    
    func test_load_success() {
        sut.setToken(token: "foo")
        
        let sut2 = TokenStore()
        XCTAssertNil(sut2.token)
        sut2.load()
        XCTAssertEqual(sut2.token, sut.token)
    }
}
