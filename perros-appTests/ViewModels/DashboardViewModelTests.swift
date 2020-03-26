//
//  DashboardViewModelTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 26/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
import Combine
@testable import perros_app

class DashboardViewModelTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    func test_getOrders_success() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            result.assertSuccess(value: ["2020"])
            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getOrderCount_validYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getOrderCount(selectedYear: 0, month: 1)
            XCTAssertEqual(10, result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getOrderCount_invalidYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getOrderCount(selectedYear: 1, month: 1)
            XCTAssertEqual(0, result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getTotalOrders_validYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getTotalOrders(selectedYear: 0)
            XCTAssertEqual("25", result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getTotalOrders_invalidYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getTotalOrders(selectedYear: 1)
            XCTAssertEqual("0", result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getAnnualBilling_validYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getAnnualBilling(selectedYear: 0)
            XCTAssertEqual("$ 100.00", result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getAnnualBilling_invalidYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getAnnualBilling(selectedYear: 1)
            XCTAssertEqual("", result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getOrderLabel_validYear_validMonth() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getOrderLabel(selectedYear: 0, month: 1)
            XCTAssertEqual("10", result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getOrderLabel_validYear_invalidMonth() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getOrderLabel(selectedYear: 0, month: 10)
            XCTAssertEqual("", result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getOrderLabel_invalidYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getOrderLabel(selectedYear: 1, month: 10)
            XCTAssertEqual("", result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getTopBilledCustomers_validYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getTopBilledCustomers(selectedYear: 0)
            XCTAssertEqual(CustomerDashboard.mockedData, result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getTopBilledCustomers_invalidYear() {
        let sut = DashboardViewModel(repository: MockDashboardRepository())
        sut.getOrders()
        
        let exp = XCTestExpectation(description: "")
        sut.$years.sinkToResult { result in
            let result = sut.getTopBilledCustomers(selectedYear: 1)
            XCTAssertEqual([], result)

            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 1.0)
    }
}
