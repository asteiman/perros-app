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
        Customer(id: 1, name: "Foo", address: "Bar")
    ]
}

extension Order {
    static let mockedData: [Order] = [
        Order(id: 1, date: Date(), status: .closed)
    ]
}

extension Billing {
    static let mockedData: [Billing] = [
        Billing(id: 1, year: "2020", month: "01", white: 100, black: 100, credit: 100)
    ]
}

extension DashboardResponse {
    static let mockedData: DashboardResponse = DashboardResponse(customers: [], orders: [], billing: [])
}

extension LoginResponse {
    static let mockedData = LoginResponse(token: "666")
}

#endif
