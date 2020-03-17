//
//  OrdersView.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct OrdersView: View {
    
    @ObservedObject var viewModel: OrdersViewModel
    
    init(viewModel: OrdersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                Text("Loading...")
            } else {
                VStack {
                    if viewModel.dataSource.isEmpty {
                        Text("No results")
                        Spacer()
                    } else {
                        List(viewModel.dataSource) { model in
                            Text(String(model.id))
                        }
                        .clipped()
                    }
                }
            }
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView(viewModel: OrdersViewModel(repository: MockCustomerRepository(), customerId: 1))
    }
}
