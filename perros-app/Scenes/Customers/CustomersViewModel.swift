//
//  CustomersViewModel.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI
import Combine

class CustomersViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var dataSource: [Customer] = []
    @Published var isLoading = true
    private var all: [Customer] = []
    
    private let repository: CustomerRepository
    private var disposables = Set<AnyCancellable>()
    
    private let scheduler = DispatchQueue(label: "CustomersViewModel")
    
    init(repository: CustomerRepository) {
        
        self.repository = repository
        getAll()
        
        $searchText
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: getCustomers(forName:))
            .store(in: &disposables)
    }
    
    private func getAll() {
        repository.getAll()
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.all = []
                case .finished:
                    break
                }
                self.isLoading = false
            },
            receiveValue: { [weak self] customers in
                guard let self = self else { return }
                self.all = customers
                self.dataSource = customers
        })
        .store(in: &disposables)
    }
    
    func getCustomers(forName name: String) {
        DispatchQueue.main.async {
            guard name.isEmpty == false else {
                self.dataSource = self.all
                return
            }
            self.dataSource = self.all.filter { $0.name.lowercased().contains(name.lowercased()) }
        }
    }
}
