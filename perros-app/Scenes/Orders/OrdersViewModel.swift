//
//  OrdersViewModel.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class OrdersViewModel: ObservableObject {
    @Published var dataSource: [Order] = []
    @Published var isLoading = false

    private let repository: CustomerRepository
    private var cancellable: AnyCancellable?
    private let customerId: Customer.ID

    init(repository: CustomerRepository, customerId: Customer.ID) {
        self.repository = repository
        self.customerId = customerId
    }

    func getOrders() {
        guard !isLoading else { return }
        isLoading = true
        cancellable = repository.getOrders(customerId: customerId)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .handleEvents(receiveCompletion: { _ in self.isLoading = false })
            .map { $0.sorted { $0.id > $1.id } }
            .assign(to: \.dataSource, on: self)
    }

    deinit {
        cancellable = nil
    }
}
