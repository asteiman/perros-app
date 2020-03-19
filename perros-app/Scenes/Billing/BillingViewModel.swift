//
//  BillingViewModel.swift
//  perros-app
//
//  Created by Alan Steiman on 18/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine

class BillingViewModel: ObservableObject {
    @Published var dataSource: [BillingReduced] = []
    @Published var isLoading = false
    
    private let repository: CustomerRepository
    private var cancellable: AnyCancellable?
    private let customerId: Customer.ID
        
    init(repository: CustomerRepository, customerId: Customer.ID) {
        
        self.repository = repository
        self.customerId = customerId
    }
    
    func getBilling() {
        guard !isLoading else { return }
        isLoading = true
        cancellable = repository.getBilling(customerId: customerId)
        .receive(on: DispatchQueue.main)
        .replaceError(with: [])
        .handleEvents(receiveCompletion: { _ in self.isLoading = false })
        .map({ billing -> [BillingReduced] in
            var final = [BillingReduced]()
            
            let years = Array(Set(billing.map ({$0.year}))).sorted(by: >)
            years.forEach { year in
                let white = billing.filter { $0.year == year }.reduce(0) { $0 + $1.white }
                let black = billing.filter { $0.year == year }.reduce(0) { $0 + $1.black }
                let credit = billing.filter { $0.year == year }.reduce(0) { $0 + $1.credit }
                
                let acum = BillingReduced(id: Int(year)!, year: year, white: PriceFormatter.format(rawPrice: white), black: PriceFormatter.format(rawPrice: black), credit: PriceFormatter.format(rawPrice: credit))
                final.append(acum)
            }
            
            return final
        })
        .assign(to: \.dataSource, on: self)
    }
    
    deinit {
        cancellable = nil
    }
}
