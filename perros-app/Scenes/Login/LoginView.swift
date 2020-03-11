//
//  LoginView.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

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
            .background(lightGreyColor)
            .cornerRadius(5)
            

            if viewModel.isError {
                Text("Invalid credentials, please try again").padding(.bottom, 10).foregroundColor(.red)
            }
            Button(action: {
                self.viewModel.login()
            }) {
                Text("Login")
                .frame(width: 200, height: 20)
                .padding()
                .background(viewModel.isValid ? Color.green : lightGreyColor)
                .foregroundColor(.white)
                .cornerRadius(4)
                .padding(.top, 10)
            }
            .disabled(!viewModel.isValid)
        }.frame(width: 350, height: nil, alignment: .center)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(repository: MockUserRepository()))
    }
}
