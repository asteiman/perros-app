//
//  Publisher.swift
//  perros-app
//
//  Created by Alan Steiman on 10/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine

extension Publisher {
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}
