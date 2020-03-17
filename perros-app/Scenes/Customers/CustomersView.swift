//
//  ContentView.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI
import Combine

//let asd = "https://perros-api.herokuapp.com/customers"

struct CustomersView: View {
    @ObservedObject var viewModel: CustomersViewModel

    init(viewModel: CustomersViewModel) {
        self.viewModel = viewModel
    }
    
    let cache = TemporaryImageCache()
    
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
                            NavigationLink(destination: CustomerDetailView(customer: model)) {
                                CustomerSingleRow(model: model, cache: self.cache)
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
