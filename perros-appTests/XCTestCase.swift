//
//  XCTestCase.swift
//  perros-appTests
//
//  Created by Alan Steiman on 23/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import XCTest
import Combine

extension XCTestCase {
    typealias CompletionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable?)
    
    func expectValue<T: Publisher>(of publisher: T,
                                   timeout: TimeInterval = 2,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   equals: [T.Output]?) -> CompletionResult where T.Output: Equatable {
        let exp = expectation(description: "Correct values of " + String(describing: publisher))
        guard var mutableEquals = equals else {
            return (exp, nil)
        }
        let cancellable = publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    guard mutableEquals.count > 0 else {
                        exp.fulfill()
                        return
                    }
                    if value == mutableEquals.first {
                        mutableEquals.remove(at: 0)
                        if mutableEquals.isEmpty {
                            exp.fulfill()
                        }
                    }
            })
        return (exp, cancellable)
    }
}
