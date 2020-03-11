//
//  LoginViewModel.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    private let repository: UserRepository
    private var disposables = Set<AnyCancellable>()
    @Published var isValid: Bool = false
    @Published var isError: Bool = false
    @Published var username: String = "" {
        didSet {
            validate()
        }
    }
    @Published var password: String = "" {
        didSet {
            validate()
        }
    }
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    private func validate() {
        isError = false
        isValid = !username.isEmpty && !password.isEmpty
    }
    
    func login() {
        repository.login(username: username, password: password).sink(receiveCompletion: { completion in
            if case .failure(_) = completion {
                self.isError = true
            }
        }) { response in
            // Nothing here
        }.store(in: &disposables)
    }
}
