//
//  CustomerRepositoryTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 24/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
import Combine
@testable import perros_app

class CustomerRepostoryTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    private var sut: RealCustomerRepository!
    
    typealias API = RealCustomerRepository.API
    typealias Mock = RequestMocking.MockedResponse
    
    override func setUp() {
        super.setUp()
        
        sut = RealCustomerRepository(session: .mockedResponsesOnly, baseURL: "https://test.com", tokenStore: MockTokenStore())
    }
    
    override func tearDown() {
        RequestMocking.removeAllMocks()
        super.tearDown()
    }
    
    func test_getAll_success() throws {
        let data = Customer.mockedData
        try mock(.all, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.getAll().sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_getAll_failure() throws {
        let data = Customer.mockedData
        try mock(.all, result: .success(data), httpCode: 500)
        let exp = XCTestExpectation(description: "Completion")
        sut.getAll().sinkToResult { result in
            switch result {
            case .failure(let error):
                XCTAssert(error == GenericError.network)
            default:
                XCTFail("Unexpected success")
            }
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_getOrders_success() throws {
        let data = Order.mockedData
        try mock(.orders(customerId: 1), result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.getOrders(customerId: 1).sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_getOrders_failure() throws {
        let data = Customer.mockedData
        try mock(.orders(customerId: 1), result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.getOrders(customerId: 1).sinkToResult { result in
            switch result {
            case .failure(let error):
                XCTAssert(error == GenericError.network)
            default:
                XCTFail("Unexpected success")
            }
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_getBilling_success() throws {
        let data = Billing.mockedData
        try mock(.billing(customerId: 1), result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.getBilling(customerId: 1).sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_getBilling_failure() throws {
        let data = Billing.mockedData
        try mock(.billing(customerId: 1), result: .success(data), httpCode: 500)
        let exp = XCTestExpectation(description: "Completion")
        sut.getBilling(customerId: 1).sinkToResult { result in
            switch result {
            case .failure(let error):
                XCTAssert(error == GenericError.network)
            default:
                XCTFail("Unexpected success")
            }
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    private func mock<T>(_ apiCall: API, result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(apiCall: apiCall, baseURL: sut.baseURL, result: result, httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}
