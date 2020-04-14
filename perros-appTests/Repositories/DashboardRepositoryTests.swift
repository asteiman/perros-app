//
//  DashboardRepositoryTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 25/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
@testable import perros_app
import XCTest

class DashboardRepostoryTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()

    private var sut: DashboardRepository!

    typealias API = RealDashboardRepository.API
    typealias Mock = RequestMocking.MockedResponse

    override func setUp() {
        super.setUp()

        sut = RealDashboardRepository(session: .mockedResponsesOnly, baseURL: "https://test.com", tokenStore: MockTokenStore())
    }

    override func tearDown() {
        RequestMocking.removeAllMocks()
        super.tearDown()
    }

    func test_get_success() throws {
        let data = DashboardResponse.mockedData
        try mock(.all, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.get().sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }

    func test_get_failure() throws {
        let data = DashboardResponse.mockedData
        try mock(.all, result: .success(data), httpCode: 500)
        let exp = XCTestExpectation(description: "Completion")
        sut.get().sinkToResult { result in
            switch result {
            case let .failure(error):
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
