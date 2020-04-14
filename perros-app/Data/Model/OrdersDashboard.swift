//
//  OrdersDashboard.swift
//  perros-app
//
//  Created by Alan Steiman on 19/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

struct DashboardResponse: Codable {
    var customers: [CustomerDashboard]
    var orders: [OrdersDashboard]
    var billing: [BillingDashboard]
}

struct BillingDashboard: Codable, Equatable {
    var year: String
    var total: Double
}

struct CustomerDashboard: Codable, Identifiable, Equatable {
    var id: Int
    var year: String
    var name: String
    var total: Double
}

struct OrdersDashboard: Codable, Equatable {
    let year: String
    let orders: [OrdersPerMonth]

    struct OrdersPerMonth: Codable, Equatable {
        let month: Int
        let count: Int
    }
}

extension DashboardResponse: Equatable {
    static func == (lhs: DashboardResponse, rhs: DashboardResponse) -> Bool {
        return lhs.billing == rhs.billing && lhs.customers == rhs.customers && lhs.orders == rhs.orders
    }
}
