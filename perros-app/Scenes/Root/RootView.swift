//
//  RootView.swift
//  perros-app
//
//  Created by Alan Steiman on 09/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            if appState.isLoggedIn {
                tabView
            } else {
                loginView
            }
        }
    }
    
    var tabView: some View {
        TabView {
            CustomersView(viewModel: CustomersViewModel(repository: RealCustomerRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: appState.tokenStore)))
            .tabItem {
                Text("Customers")
            }
            AccountView(repository: RealUserRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: appState.tokenStore))
            .tabItem {
                Text("Account")
            }
        }
    }
    
    var loginView: some View {
        LoginView(viewModel: LoginViewModel(repository: RealUserRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: appState.tokenStore)))
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
