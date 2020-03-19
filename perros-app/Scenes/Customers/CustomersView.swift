//
//  ContentView.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI
import Combine

struct CustomersView: View {
    @ObservedObject var viewModel: CustomersViewModel
    @EnvironmentObject var appState: AppState

    init(viewModel: CustomersViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                Text("Loading...")
            } else {
                VStack {
                    SearchBarView(searchText: $viewModel.searchText)
                    if viewModel.dataSource.isEmpty {
                        Text("No results")
                        Spacer()
                    } else {
                        List(viewModel.dataSource) { model in
                            NavigationLink(destination: CustomerDetailView(
                                customer: model,
                                ordersViewModel: OrdersViewModel(repository: RealCustomerRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: self.appState.tokenStore), customerId: model.id), billingViewModel: BillingViewModel(repository: RealCustomerRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: self.appState.tokenStore), customerId: model.id))) {
                                CustomerSingleRow(model: model, cache: self.appState.cache)
                            }
                        }
                        .clipped()
                    }
                }
                .resignKeyboardOnDragGesture()
                .navigationBarTitle("Customers", displayMode: .inline)
            }
        }
    }
}

struct CustomersView_Previews: PreviewProvider {
    static let viewModel = CustomersViewModel(repository: MockCustomerRepository())
    
    static var previews: some View {
        CustomersView(viewModel: viewModel)
    }
}
