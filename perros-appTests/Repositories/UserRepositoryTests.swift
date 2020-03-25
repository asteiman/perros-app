//
//  UserRepositoryTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 25/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
import Combine
@testable import perros_app

class UserRepostoryTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    private var sut: UserRepository!
    private let tokenStore = MockTokenStore()
    
    typealias API = RealUserRepository.API
    typealias Mock = RequestMocking.MockedResponse
    
    override func setUp() {
        super.setUp()
        
        sut = RealUserRepository(session: .mockedResponsesOnly, baseURL: "https://test.com", tokenStore: tokenStore)
    }
    
    override func tearDown() {
        RequestMocking.removeAllMocks()
        super.tearDown()
    }
    
    func test_login_success() throws {
        let data = LoginResponse.mockedData
        try mock(.login(username: "foo", password: "bar"), result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.login(username: "foo", password: "bar").sinkToResult { _ in
            XCTAssertNotNil(self.tokenStore.token)
            XCTAssertEqual(self.tokenStore.token!, "666")
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_login_failure() throws {
        let data = LoginResponse.mockedData
        try mock(.login(username: "foo", password: "bar"), result: .success(data), httpCode: 500)
        let exp = XCTestExpectation(description: "Completion")
        sut.login(username: "foo", password: "bar").sinkToResult { result in
            switch result {
            case .failure(let error):
                XCTAssert(error as? GenericError == GenericError.network)
            default:
                XCTFail("Unexpected success")
            }
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_logout_success() {
        XCTAssertNotNil(tokenStore.token)
        sut.logout()
        XCTAssertNil(tokenStore.token)
    }
    
    private func mock<T>(_ apiCall: API, result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(apiCall: apiCall, baseURL: sut.baseURL, result: result, httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}
