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

    init(viewModel: CustomersViewModel = CustomersViewModel()) {
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
                            CustomerSingleRow(model: model)
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
