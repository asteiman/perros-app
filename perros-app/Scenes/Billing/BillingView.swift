//
//  BillingView.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

import SwiftUI

struct BillingView: View {
    
    @ObservedObject var viewModel: BillingViewModel
    
    init(viewModel: BillingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            Text("").onAppear { self.viewModel.getBilling() }
            if viewModel.isLoading {
                Text("Loading...")
            } else {
                VStack {
                    if viewModel.dataSource.isEmpty {
                        Text("No results")
                        Spacer()
                    } else {
                        List(viewModel.dataSource) { model in
                            VStack(alignment: .trailing) {
                                HStack {
                                    ZStack {
                                        Text(String(model.year))
                                            .font(.callout)
                                            .padding(6)
                                            .foregroundColor(.white)
                                    }.background(Color.black)
                                    .opacity(0.8)
                                    .cornerRadius(10.0)
                                    .padding(6)
                                    Spacer()
                                    HStack {
                                        Text(String(model.white)).frame(minWidth: 90)
                                        Text(String(model.black)).frame(minWidth: 90)
                                        Text(String(model.credit)).frame(minWidth: 80)
                                    }
                                }
                            }
                        }
                        .onAppear {
                            UITableView.appearance().separatorStyle = .none
                        }
                        .onDisappear {
                            UITableView.appearance().separatorStyle = .singleLine
                        }
                        .clipped()
                    }
                }
            }
        }
    }
}

struct BillingView_Previews: PreviewProvider {
    static var previews: some View {
        return BillingView(viewModel: BillingViewModel(repository: MockCustomerRepository(), customerId: 1))
    }
}
