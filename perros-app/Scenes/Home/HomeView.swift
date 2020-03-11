//
//  HomeView.swift
//  perros-app
//
//  Created by Alan Steiman on 09/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            CustomersView()
            .tabItem {
                Text("Customers")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
