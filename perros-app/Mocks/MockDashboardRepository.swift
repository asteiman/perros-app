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
    func getOrders() -> AnyPublisher<[OrdersDashboard], GenericError> {
        Just([OrdersDashboard(year: "year", orders: [OrdersDashboard.OrdersPerMonth(month: 1, count: 100)])])
        .setFailureType(to: GenericError.self)
        .eraseToAnyPublisher()
    }
}
