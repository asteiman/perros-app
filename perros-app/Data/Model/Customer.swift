//
//  Customer.swift
//  perros-app
//
//  Created by Alan Steiman on 11/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

struct Customer: Codable, Identifiable {
    var id: Int
    var name: String
    var address: String
}