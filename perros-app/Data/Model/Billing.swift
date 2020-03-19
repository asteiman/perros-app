//
//  Billing.swift
//  perros-app
//
//  Created by Alan Steiman on 18/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

struct Billing: Codable, Identifiable {
    var id: Int
    var year: String
    var month: String
    var white: Double
    var black: Double
    var credit: Double
}
