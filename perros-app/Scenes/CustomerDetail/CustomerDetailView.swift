//
//  CustomerDetailView.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct CustomerDetailView: View {
    @EnvironmentObject var appState: AppState

    let customer: Customer
    @State private var selectedTab = 0
    private let ordersViewModel: OrdersViewModel
    private let billingViewModel: BillingViewModel
    
    init(customer: Customer, ordersViewModel: OrdersViewModel, billingViewModel: BillingViewModel) {
        self.customer = customer
        self.ordersViewModel = ordersViewModel
        self.billingViewModel = billingViewModel
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: customer.avatar)!, placeholder: Image("default-avatar").resizable(), cache: appState.cache).frame(width: 100, height: 100).aspectRatio(contentMode: .fit).cornerRadius(100)
                
                VStack(alignment: .leading) {
                    Spacer().frame(height: 10)
                    Text(customer.name).font(.title)
                    Spacer().frame(height: 10)
                    Text(customer.address).font(.subheadline)
                }
                Spacer()
            }
            Picker("Numbers", selection: $selectedTab) {
                Text("Orders").tag(0)
                Text("Billing").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            if selectedTab == 0 {
                OrdersView(viewModel: self.ordersViewModel)
            } else {
                BillingView(viewModel: self.billingViewModel)
            }
            Spacer()
        }.padding(12)
    }
}

struct CustomerDetailView_Previews: PreviewProvider {
    static let customerId = 1
    static let repo = MockCustomerRepository()
    static var previews: some View {
        CustomerDetailView(customer: Customer(id: 1, name: "Lorem Ipsum", address: "sed do eiusmod tempor incididunt"), ordersViewModel: OrdersViewModel(repository: repo, customerId: customerId), billingViewModel: BillingViewModel(repository: repo, customerId: customerId))
    }
}
