//
//  OrdersDashboardTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 27/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

@testable import perros_app
import XCTest

class OrdersDashboardTests: XCTestCase {
    func test_equal() {
        let dash = DashboardResponse(customers: [], orders: [], billing: [])
        let dash2 = DashboardResponse(customers: [], orders: [], billing: [])
        XCTAssertEqual(dash, dash2)
    }

    func test_equal2() {
        let dash = DashboardResponse(customers: [], orders: [], billing: [BillingDashboard(year: "2020", total: 10)])
        let dash2 = DashboardResponse(customers: [], orders: [], billing: [BillingDashboard(year: "2020", total: 10)])
        XCTAssertEqual(dash, dash2)
    }

    func test_notequal() {
        let dash = DashboardResponse(customers: [CustomerDashboard(id: 1, year: "", name: "", total: 1)], orders: [], billing: [])
        let dash2 = DashboardResponse(customers: [], orders: [], billing: [])
        XCTAssertNotEqual(dash, dash2)
    }
}
