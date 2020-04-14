//
//  AccountView.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    var body: some View {
        NavigationView {
            Button(action: {
                self.repository.logout()
            }) {
                Text("Logout")
            }
            .navigationBarTitle("Account", displayMode: .inline)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = ColorKit.danube
                let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
                nc.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key: Any]
            })
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(repository: MockUserRepository())
    }
}
