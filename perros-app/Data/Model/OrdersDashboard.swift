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
}

struct CustomerDashboard: Codable, Identifiable {
    var id: Int
    var name: String
    var total: Double
}

struct OrdersDashboard: Codable {
    let year: String
    let orders: [OrdersPerMonth]
    
    struct OrdersPerMonth: Codable {
        let month: Int
        let count: Int
    }
}
