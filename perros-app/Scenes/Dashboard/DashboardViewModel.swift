//
//  DashboardViewModel.swift
//  perros-app
//
//  Created by Alan Steiman on 19/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class DashboardViewModel: ObservableObject {
    private var all: [OrdersDashboard] = []
    @Published var years: [String] = []
    @Published var isLoading = false
    private var disposables = [AnyCancellable]()
    
    private let repository: DashboardRepository
    private var cancellable: AnyCancellable?
        
    init(repository: DashboardRepository) {
        self.repository = repository
    }
    
    func getOrderLabel(selectedYear: Int, month: Int) -> String {
        let orderCount = getOrderCount(selectedYear: selectedYear, month: month)
        return orderCount == 0 ? "" : "\(orderCount)"
    }
    
    func getOrderCount(selectedYear: Int, month: Int) -> Int {
        guard years.count > selectedYear else { return 0 }
        let year = years[selectedYear]
        
        return all.filter { $0.year == year }.flatMap {$0.orders}.filter {$0.month == month}.first?.count ?? 0
    }
    
    func getOrders() {
        guard !isLoading else { return }
        isLoading = true
        cancellable = repository.getOrders()
        .receive(on: DispatchQueue.main)
        .replaceError(with: [])
        .handleEvents(receiveCompletion: { _ in
            self.isLoading = false
            self.years = self.all.map { $0.year }
        })
        .assign(to: \.all, on: self)
    }
    
    deinit {
        cancellable = nil
    }
}
