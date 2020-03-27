//
//  OrderTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 27/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
import SwiftUI
@testable import perros_app

class OrderTests: XCTestCase {
    
    func test_statusLabel() {
        let order = Order(id: 1, date: Date(), status: .closed)
        XCTAssertEqual("Closed", order.status.label())
        
        let order2 = Order(id: 1, date: Date(), status: .deleted)
        XCTAssertEqual("Deleted", order2.status.label())
        
        let order3 = Order(id: 1, date: Date(), status: .draft)
        XCTAssertEqual("Draft", order3.status.label())
    }
    
    func test_statusColor() {
        let order = Order(id: 1, date: Date(), status: .closed)
        XCTAssertEqual(Color.green, order.status.color())
        
        let order2 = Order(id: 1, date: Date(), status: .deleted)
        XCTAssertEqual(Color.red, order2.status.color())

        let order3 = Order(id: 1, date: Date(), status: .draft)
        XCTAssertEqual(Color.yellow, order3.status.color())
    }
    
    func test_equal() {
        let order = Order(id: 1, date: Date(), status: .closed)
        
        let order2 = Order(id: 1, date: Date(), status: .closed)
        XCTAssertEqual(order, order2)
    }
    
    func test_notEqual() {
        let order = Order(id: 1, date: Date(), status: .closed)
        
        let order2 = Order(id: 2, date: Date(), status: .closed)
        XCTAssertNotEqual(order, order2)
    }
    
    func test_formattedDate() {
        let order = Order(id: 1, date: Date(timeIntervalSince1970: TimeInterval(exactly: 1234567890)!), status: .closed)
        XCTAssertEqual("14 Feb 2009, 07:31", order.formattedDate)
    }
}
