//
//  DashboardViewModel.swift
//  perros-app
//
//  Created by Alan Steiman on 19/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class DashboardViewModel: ObservableObject {
    private var response: DashboardResponse?
    @Published var years: [String] = []
    @Published var isLoading = false

    private let repository: DashboardRepository
    private var cancellable: AnyCancellable?

    init(repository: DashboardRepository) {
        self.repository = repository
    }

    func getAnnualBilling(selectedYear: Int) -> String {
        guard years.count > selectedYear else { return "" }
        let year = years[selectedYear]

        let total = response?.billing.filter { $0.year == year }.first?.total ?? 0

        return PriceFormatter.format(rawPrice: total)
    }

    func getTopBilledCustomers(selectedYear: Int) -> [CustomerDashboard] {
        guard years.count > selectedYear else { return [] }
        let year = years[selectedYear]

        return response?.customers.filter { $0.year == year } ?? []
    }

    func getOrderLabel(selectedYear: Int, month: Int) -> String {
        let orderCount = getOrderCount(selectedYear: selectedYear, month: month)
        return orderCount == 0 ? "" : "\(orderCount)"
    }

    func getOrderCount(selectedYear: Int, month: Int) -> Int {
        guard years.count > selectedYear else { return 0 }
        let year = years[selectedYear]

        return response?.orders.filter { $0.year == year }.flatMap { $0.orders }.filter { $0.month == month }.first?.count ?? 0
    }

    func getTotalOrders(selectedYear: Int) -> String {
        guard years.count > selectedYear else { return "0" }
        let year = years[selectedYear]

        guard let ordersThisYear = response?.orders.filter({ $0.year == year }) else {
            return "0"
        }

        return String(ordersThisYear.flatMap { $0.orders }.reduce(0) { total, thisMonth in
            total + thisMonth.count
        })
    }

    func getOrders() {
        guard !isLoading else { return }
        isLoading = true
        cancellable = repository.get().sink(receiveCompletion: { _ in
            self.isLoading = false
        }, receiveValue: { response in
            self.response = response
            self.years = response.orders.map { $0.year }
        })
    }

    deinit {
        cancellable = nil
    }
}
