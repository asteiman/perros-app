//
//  LoginView.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("Admin PER-ROS").font(.title).padding()
            Group {
                TextField("Username", text: $viewModel.username)
                SecureField("Pasword", text: $viewModel.password)
            }
            .padding()
            .frame(width: nil, height: 60)
            .background(ColorKit.lightGreyColor)
            .cornerRadius(5)

            if viewModel.isError {
                Text("Invalid credentials, please try again").padding(.bottom, 10).foregroundColor(.red)
            }
            Button(action: {
                self.viewModel.login()
            }) {
                Text(viewModel.isLoading ? "Loading ..." : "Login")
                    .frame(width: 200, height: 20)
                    .padding()
                    .background(viewModel.isValid ? Color.green : ColorKit.lightGreyColor)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .padding(.top, 10)
            }
            .disabled(!viewModel.isValid)
        }.frame(width: 350, height: nil, alignment: .center).keyboardResponsive()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(repository: MockUserRepository()))
    }
}
