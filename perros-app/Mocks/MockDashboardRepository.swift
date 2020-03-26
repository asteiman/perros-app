//
//  MockDashboardRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 19/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine

final class MockDashboardRepository: TestWebRepository, DashboardRepository {
    func get() -> AnyPublisher<DashboardResponse, GenericError> {
        let response = DashboardResponse(customers: CustomerDashboard.mockedData, orders: OrdersDashboard.mockedData, billing: BillingDashboard.mockedData)
        return Just(response)
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
}
