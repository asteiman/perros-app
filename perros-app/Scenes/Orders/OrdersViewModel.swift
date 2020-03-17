//
//  OrdersViewModel.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

import SwiftUI
import Combine

class OrdersViewModel: ObservableObject {
    @Published var dataSource: [Order] = []
    @Published var isLoading = true
    
    private let repository: CustomerRepository
    private var disposables = Set<AnyCancellable>()
        
    init(repository: CustomerRepository) {
        
        self.repository = repository
    }
    
    func getBy(customerId: Customer.ID) {
        repository.getOrders(customerId: customerId)
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = []
                case .finished:
                    break
                }
                self.isLoading = false
            },
            receiveValue: { [weak self] orders in
                guard let self = self else { return }
                self.dataSource = orders
        })
        .store(in: &disposables)
    }
}
