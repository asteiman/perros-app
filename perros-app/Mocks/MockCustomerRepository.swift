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
    let response: [Codable]?
    let error: Error?
    
    init(response: [Codable]? = nil, error: Error? = nil) {
        self.response = response
        self.error = error
    }
    
    func getAll() -> AnyPublisher<[Customer], GenericError> {
        if let error = error as? GenericError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(response as! [Customer])
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
    
    func getOrders(customerId: Customer.ID) -> AnyPublisher<[Order], GenericError> {
        if let error = error as? GenericError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(response as! [Order])
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
    
    func getBilling(customerId: Customer.ID) -> AnyPublisher<[Billing], GenericError> {
        if let error = error as? GenericError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(response as! [Billing])
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
}
