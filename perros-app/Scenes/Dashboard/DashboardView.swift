//
//  DashboardView.swift
//  perros-app
//
//  Created by Alan Steiman on 19/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Combine
import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var selectedYear = 0
    private let cornerRadius: CGFloat = 5

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView {
                    Picker("", selection: self.$selectedYear) {
                        ForEach(0 ..< self.viewModel.years.count, id: \.self) {
                            Text(self.viewModel.years[$0]).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    Text("Closed orders").font(.title)

                    self.graph()

                    HStack {
                        self.squareView(using: geo, title: "Total Closed Orders", number: self.viewModel.getTotalOrders(selectedYear: self.selectedYear))
                        self.squareView(using: geo, title: "Annual Billing", number: self.viewModel.getAnnualBilling(selectedYear: self.selectedYear))
                    }.padding(.top, 16)

                    self.topBilled()
                }
            }.navigationBarTitle("Dashboard", displayMode: .inline)
                .onAppear {
                    self.viewModel.getOrders()
                }.background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = ColorKit.danube
                    let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
                    nc.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key: Any]
            })
        }
    }

    func topBilled() -> some View {
        return ZStack {
            Color.white.shadow(color: .gray, radius: 3, x: 0, y: 0)

            VStack {
                Text("Top Billed Customers").font(.title).padding(.bottom, 20).padding(.top, 10)
                ForEach(self.viewModel.getTopBilledCustomers(selectedYear: self.selectedYear)) { customer in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(customer.name).lineLimit(1)
                            Spacer()
                            Text(PriceFormatter.format(rawPrice: customer.total))
                        }
                        Divider()
                    }
                }.padding(.leading, 16).padding(.trailing, 16)
            }
        }.padding()
    }

    func squareView(using proxy: GeometryProxy, title: String, number: String) -> some View {
        let margin: CGFloat = 36
        let width = proxy.size.width / 2
        let side = width - margin
        return ZStack {
            Color.white
            VStack {
                Text(title).font(.headline).padding(.top, 20).lineLimit(1).minimumScaleFactor(0.5)
                Spacer()
            }
            VStack {
                Text(number).font(.system(size: 60)).lineLimit(1).minimumScaleFactor(0.3).padding(.leading, 5).padding(.trailing, 5)
            }
        }.cornerRadius(cornerRadius).frame(width: side, height: side).padding(16)
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
    }

    func graph() -> some View {
        return ZStack {
            ColorKit.lightGreyColor.frame(width: nil, height: 220)
            HStack {
                ForEach(1 ..< 13) { month in
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
                            .cornerRadius(self.cornerRadius)
                        Text("\(DateUtilities.monthAbbreviationFromInt(month))")
                            .font(.footnote)
                            .frame(width: nil, height: 20)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel(repository: MockDashboardRepository()))
    }
}
