//
//  ImageLoaderTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 26/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
import Combine
@testable import perros_app

class ImageLoaderTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    
    func testImageLoader_success() {
        let sut = ImageLoader(url: URL(string: "https://picsum.photos/20")!, cache: nil, session: .shared)
        sut.load()
        let exp = XCTestExpectation(description: "")
        sut.$image.dropFirst(1).sinkToResult { result in
            let image = try? result.get()
            XCTAssertNotNil(image)
            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 5)
    }
    
    func testImageLoader_failure() {
        let sut = ImageLoader(url: URL(string: "https://www.google.com")!, cache: nil, session: .shared)
        sut.load()
        let exp = XCTestExpectation(description: "")
        sut.$image.dropFirst(1).sinkToResult { result in
            let image = try? result.get()
            XCTAssertNil(image)
            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 5)
    }
    
    func testImageLoader_startWithEmpty() {
        let sut = ImageLoader(url: URL(string: "https://www.google.com")!, cache: nil, session: .shared)
        sut.load()
        let exp = XCTestExpectation(description: "")
        sut.$image.sinkToResult { result in
            let image = try? result.get()
            XCTAssertNil(image)
            exp.fulfill()
        }.store(in: &subscriptions)
        
        wait(for: [exp], timeout: 5)
    }
}
