//
//  AppState.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import Combine
import KeychainAccess
import SwiftUI

final class AppState: ObservableObject {
    @ObservedObject var tokenStore = TokenStore()
    var cache = TemporaryImageCache()
    
    @Published var isLoggedIn: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
        tokenStore.tokenSubject.receive(on: DispatchQueue.main).sink {
            self.isLoggedIn = self.tokenStore.token != nil
        }.store(in: &disposables)
        
        tokenStore.load()
    }
    
    func getTokenStorage() -> TokenStorage {
        return tokenStore
    }
}
