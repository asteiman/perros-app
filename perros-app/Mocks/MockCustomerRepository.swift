//
//  MockCustomerRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine

final class MockCustomerRepository: TestWebRepository, CustomerRepository {
    func getAll() -> AnyPublisher<[Customer], Error> {
        Just([Customer(id: 1, name: "John Doe", address: "1 Infinite Loop")])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
