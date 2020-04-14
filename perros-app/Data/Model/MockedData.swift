//
//  MockedData.swift
//  perros-app
//
//  Created by Alan Steiman on 24/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

#if DEBUG

    extension Customer {
        static let mockedData: [Customer] = [
            Customer(id: 1, name: "Foo", address: "Bar"),
            Customer(id: 2, name: "Baz", address: "Tar"),
        ]
    }

    extension Order {
        static let mockedData: [Order] = [
            Order(id: 1, date: Date(), status: .closed),
        ]
    }

    extension Billing {
        static let mockedData: [Billing] = [
            Billing(id: 1, year: "2020", month: "01", white: 100, black: 100, credit: 100),
        ]
    }

    extension BillingReduced {
        static let mockedData: [BillingReduced] = [
            BillingReduced(id: 2020, year: "2020", white: "$ 100.00", black: "$ 100.00", credit: "$ 100.00"),
        ]
    }

    extension DashboardResponse {
        static let mockedData: DashboardResponse = DashboardResponse(customers: [], orders: [], billing: [])
    }

    extension LoginResponse {
        static let mockedData = LoginResponse(token: "666")
    }

    extension BillingDashboard {
        static let mockedData: [BillingDashboard] = [
            BillingDashboard(year: "2020", total: 100),
        ]
    }

    extension OrdersDashboard {
        static let mockedData: [OrdersDashboard] = [
            OrdersDashboard(year: "2020", orders: [OrdersPerMonth(month: 1, count: 10), OrdersPerMonth(month: 2, count: 15)]),
        ]
    }

    extension CustomerDashboard {
        static let mockedData: [CustomerDashboard] = [
            CustomerDashboard(id: 1, year: "2020", name: "foo", total: 100),
            CustomerDashboard(id: 2, year: "2020", name: "foo", total: 100),
        ]
    }

#endif
