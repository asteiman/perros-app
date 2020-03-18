//
//  Order.swift
//  perros-app
//
//  Created by Alan Steiman on 17/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import SwiftUI

struct Order: Codable, Identifiable {
    var id: Int
    var date: Date
    var status: Order.Status
}

extension Order {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y, HH:mm"
        return formatter.string(from: date)
    }
}

extension Order {
    enum Status: Int, Codable {
        case draft
        case closed
        case deleted
    }
}

extension Order.Status {
    func label() -> String {
        switch self {
        case .closed:
            return "Closed"
        case .deleted:
            return "Deleted"
        case .draft:
            return "Draft"
        }
    }
    
    func color() -> Color {
        switch self {
        case .closed:
            return .green
        case .deleted:
            return .red
        case .draft:
            return .yellow
        }
    }
}
