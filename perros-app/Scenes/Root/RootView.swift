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
    @State private var selected = 0

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
        UIKitTabView([
            UIKitTabView.Tab(
                view: DashboardView(viewModel: DashboardViewModel(repository: RealDashboardRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: appState.getTokenStorage()))),
                barItem: UITabBarItem(title: "Dashboard", image: UIImage(systemName: "chart.bar"), selectedImage: UIImage(systemName: "chart.bar.fill"))
            ),
            UIKitTabView.Tab(
                view: CustomersView(viewModel: CustomersViewModel(repository: RealCustomerRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: appState.getTokenStorage()))),
                barItem: UITabBarItem(title: "Customers", image: UIImage(systemName: "person.3"), selectedImage: UIImage(systemName: "person.3.fill"))
            ),
            UIKitTabView.Tab(
                view: AccountView(repository: RealUserRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: appState.getTokenStorage())),
                barItem: UITabBarItem(title: "Account", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
            ),
        ])
    }

    var loginView: some View {
        LoginView(viewModel: LoginViewModel(repository: RealUserRepository(session: .shared, baseURL: Config.baseUrl, tokenStore: appState.getTokenStorage())))
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
