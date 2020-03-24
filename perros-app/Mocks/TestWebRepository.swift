//
//  TestWebRepository.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

class TestWebRepository: WebRepository {
    var tokenStore: TokenStorage = TokenStore()
    let session: URLSession = .shared
    let baseURL = "https://test.com"
    let bgQueue = DispatchQueue(label: "test")
}
