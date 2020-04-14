//
//  OrdersViewModelTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 23/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

@testable import perros_app
import SwiftUI
import XCTest

class OrdersViewModelTests: XCTestCase {
    func testGetOrders_Success() {
        let viewModel = OrdersViewModel(repository: MockCustomerRepository(response: [Order(id: 1, date: Date(), status: .closed)]), customerId: 1)

        let result = [Order(id: 1, date: Date(), status: .closed)]
        let exp = expectValue(of: viewModel.$dataSource.eraseToAnyPublisher(), equals: [result])
        viewModel.getOrders()

        wait(for: [exp.expectation], timeout: 1.0)
    }

    func testGetOrders_Failure() {
        let viewModel = OrdersViewModel(repository: MockCustomerRepository(error: GenericError.network), customerId: 1)

        let exp = expectValue(of: viewModel.$dataSource.eraseToAnyPublisher(), equals: [])
        viewModel.getOrders()

        wait(for: [exp.expectation], timeout: 1.0)
    }

    func testGetOrders_isLoading() {
        let viewModel = OrdersViewModel(repository: MockCustomerRepository(error: GenericError.network), customerId: 1)
        viewModel.isLoading = true

        let exp = expectValue(of: viewModel.$dataSource.eraseToAnyPublisher(), equals: nil)
        exp.expectation.isInverted = true
        viewModel.getOrders()

        wait(for: [exp.expectation], timeout: 1.0)
    }
}
