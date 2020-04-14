//
//  CustomersViewModelTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 26/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
@testable import perros_app
import XCTest

class CustomersViewModelTests: XCTestCase {
    var subscription = Set<AnyCancellable>()

    func test_getBilling_success() {
        let sut = CustomersViewModel(repository: MockCustomerRepository(response: Customer.mockedData, error: nil))

        let exp = XCTestExpectation(description: "")
        sut.$dataSource.dropFirst(1).sinkToResult { result in
            result.assertSuccess(value: Customer.mockedData)
            exp.fulfill()
        }.store(in: &subscription)
        wait(for: [exp], timeout: 1.0)
    }

    func test_getBilling_failure() {
        let sut = CustomersViewModel(repository: MockCustomerRepository(response: nil, error: GenericError.network))

        let exp = XCTestExpectation(description: "")
        exp.isInverted = true
        sut.$dataSource.dropFirst(1).sinkToResult { _ in
            exp.fulfill()
        }.store(in: &subscription)
        wait(for: [exp], timeout: 1.0)
    }

    func test_getBilling_sortDesc() {
        let sut = CustomersViewModel(repository: MockCustomerRepository(response: Customer.mockedData, error: nil))

        let exp = XCTestExpectation(description: "")
        sut.$dataSource.dropFirst(2).sinkToResult { result in
            result.assertSuccess(value: Customer.mockedData.reversed())
            exp.fulfill()
        }.store(in: &subscription)

        sut.sortAsc.toggle()
        wait(for: [exp], timeout: 1.0)
    }

    func test_getBilling_sortAsc() {
        let sut = CustomersViewModel(repository: MockCustomerRepository(response: Customer.mockedData, error: nil))

        let exp = XCTestExpectation(description: "")
        sut.$dataSource.dropFirst(3).sinkToResult { result in
            result.assertSuccess(value: Customer.mockedData)
            exp.fulfill()
        }.store(in: &subscription)

        sut.sortAsc.toggle()
        sut.sortAsc.toggle()

        wait(for: [exp], timeout: 1.0)
    }

    func test_getBilling_filterWithValidString() {
        let sut = CustomersViewModel(repository: MockCustomerRepository(response: Customer.mockedData, error: nil))

        let exp = XCTestExpectation(description: "")
        sut.$dataSource.dropFirst(2).sinkToResult { result in
            result.assertSuccess(value: Array(Customer.mockedData.prefix(1)))
            exp.fulfill()
        }.store(in: &subscription)

        sut.searchText = "foo"

        wait(for: [exp], timeout: 1.0)
    }

    func test_getBilling_filterWithEmptyString() {
        let sut = CustomersViewModel(repository: MockCustomerRepository(response: Customer.mockedData, error: nil))

        let exp = XCTestExpectation(description: "")
        sut.$dataSource.dropFirst(2).sinkToResult { result in
            result.assertSuccess(value: Customer.mockedData)
            exp.fulfill()
        }.store(in: &subscription)

        sut.searchText = ""

        wait(for: [exp], timeout: 1.0)
    }
}
