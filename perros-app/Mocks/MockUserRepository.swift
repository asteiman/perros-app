//
//  MockUserRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine

final class MockUserRepository: TestWebRepository, UserRepository {
    func login(username: String, password: String) -> AnyPublisher<Void, Error> {
        Just(())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    func logout() {
        //
    }
}
