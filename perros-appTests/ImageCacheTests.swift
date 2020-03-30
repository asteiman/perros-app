//
//  ImageCacheTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 30/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
@testable import perros_app

class ImageCacheTests: XCTestCase {
    
    func test_cache_miss() {
        let sut = TemporaryImageCache()
        
        let url = URL(string: "https://www.google.com")!
        XCTAssertNil(sut[url])
    }
    
    func test_cache_hit() {
        var sut = TemporaryImageCache()
        
        let image = UIImage()
        
        let url = URL(string: "https://www.google.com")!
        
        sut[url] = image
        XCTAssertEqual(sut[url], image)
    }
    
    func test_cache_delete() {
        var sut = TemporaryImageCache()
        
        let image = UIImage()
        
        let url = URL(string: "https://www.google.com")!
        
        sut[url] = image
        XCTAssertEqual(sut[url], image)
        
        sut[url] = nil
        
        XCTAssertNil(sut[url])
    }
}
