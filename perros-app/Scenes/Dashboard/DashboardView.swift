//
//  DashboardView.swift
//  perros-app
//
//  Created by Alan Steiman on 19/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI
import Combine

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var selectedYear = 0
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Numbers", selection: $selectedYear) {
                    ForEach(0..<self.viewModel.years.count, id: \.self) {
                        Text(self.viewModel.years[$0]).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Text("Closed orders").font(.title)
                
                ZStack {
                    lightGreyColor.frame(width: nil, height: 280).cornerRadius(3).padding()
                    HStack {
                        ForEach(1..<13) { month in
                            VStack {
                                Spacer()
                                Text(self.viewModel.getOrderLabel(selectedYear: self.selectedYear, month: month))
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                .offset(y: 0)
                                .zIndex(1)
                                
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: 20, height: CGFloat(integerLiteral: self.viewModel.getOrderCount(selectedYear: self.selectedYear, month: month)))
                                    .cornerRadius(3)
                                Text("\(DateUtilities.monthAbbreviationFromInt(month))")
                                    .font(.footnote)
                                    .frame(height: 20)
                            }
                        }
                    }.frame(width: nil, height: 250)
                }
                Spacer()
            }.navigationBarTitle("Dashboard", displayMode: .inline)
            .onAppear {
                self.viewModel.getOrders()
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel(repository: MockDashboardRepository()))
    }
}
