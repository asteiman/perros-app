//
//  PriceFormatter.swift
//  perros-app
//
//  Created by Alan Steiman on 18/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

class PriceFormatter {
    static func format(rawPrice: Double?) -> String {
        let unrwappedPrice = rawPrice ?? 0

        return String(format: "$ %.2f", unrwappedPrice)
    }
}
