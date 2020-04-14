//
//  ContentView.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import SwiftUI

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
                    SearchBarView(searchText: $viewModel.searchText, sortAsc: $viewModel.sortAsc)
                    if viewModel.dataSource.isEmpty {
                        Text("No results")
                        Spacer()
                    } else {
                        List(viewModel.dataSource) { model in
                            NavigationLink(destination: CustomerDetailView(
                                customer: model,
                                ordersViewModel: OrdersViewModel(repository: RealCustomerRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: self.appState.getTokenStorage()), customerId: model.id), billingViewModel: BillingViewModel(repository: RealCustomerRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: self.appState.getTokenStorage()), customerId: model.id)
                            )) {
                                CustomerSingleRow(model: model, cache: self.appState.cache)
                            }
                        }.id(UUID())
                            .clipped()
                    }
                }
                .resignKeyboardOnDragGesture()
                .navigationBarTitle("Customers", displayMode: .inline)
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = ColorKit.danube
                    let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
                    nc.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key: Any]
                })
            }
        }.accentColor(.white)
    }
}

struct CustomersView_Previews: PreviewProvider {
    static let viewModel = CustomersViewModel(repository: MockCustomerRepository())

    static var previews: some View {
        CustomersView(viewModel: viewModel)
    }
}
