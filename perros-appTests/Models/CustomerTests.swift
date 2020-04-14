//
//  CustomerTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 27/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

@testable import perros_app
import XCTest

class CustomerTests: XCTestCase {
    func test_statusLabel() {
        let customer = Customer(id: 1, name: "name", address: "name")
        XCTAssertEqual("https://picsum.photos/id/1/100", customer.avatar)
    }
}
