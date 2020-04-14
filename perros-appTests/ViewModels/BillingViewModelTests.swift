//
//  BillingViewModelTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 26/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
@testable import perros_app
import XCTest

class BillingViewModelTests: XCTestCase {
    var subscription = Set<AnyCancellable>()

    func test_getBilling_success() {
        let sut = BillingViewModel(repository: MockCustomerRepository(response: Billing.mockedData, error: nil), customerId: 1)
        sut.getBilling()

        let exp = XCTestExpectation(description: "")
        sut.$dataSource.dropFirst(1).sinkToResult { result in
            result.assertSuccess(value: BillingReduced.mockedData)
            exp.fulfill()
        }.store(in: &subscription)
        wait(for: [exp], timeout: 1.0)
    }

    func test_getBilling_isLoading() {
        let sut = BillingViewModel(repository: MockCustomerRepository(response: Billing.mockedData, error: nil), customerId: 1)
        sut.isLoading = true
        sut.getBilling()

        let exp = XCTestExpectation(description: "")
        exp.isInverted = true
        wait(for: [exp], timeout: 1.0)
    }
}
