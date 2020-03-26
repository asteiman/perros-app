//
//  PriceFormatterTests.swift
//  perros-appTests
//
//  Created by Alan Steiman on 26/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
@testable import perros_app

class PriceFormatterTests: XCTestCase {
    
    func test_format_valid() {
        XCTAssertEqual(PriceFormatter.format(rawPrice: 1.5234), "$ 1.52")
    }
    
    func test_format_invalid() {
        XCTAssertEqual(PriceFormatter.format(rawPrice: nil), "$ 0.00")
    }
}
