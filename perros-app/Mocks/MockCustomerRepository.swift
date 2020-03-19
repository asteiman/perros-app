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
    func getAll() -> AnyPublisher<[Customer], GenericError> {
        Just([Customer(id: 1, name: "John Doe", address: "1 Infinite Loop")])
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
    
    func getOrders(customerId: Customer.ID) -> AnyPublisher<[Order], GenericError> {
        Just([Order(id: 1, date: Date(), status: .closed)])
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
    
    func getBilling(customerId: Customer.ID) -> AnyPublisher<[Billing], GenericError> {
        Just([Billing(id: 1, year: "2020", month: "01", white: 1.0, black: 1.0, credit: 0)])
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
}
