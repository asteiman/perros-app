//
//  MockedData.swift
//  perros-app
//
//  Created by Alan Steiman on 24/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation

#if DEBUG

extension Customer {
    static let mockedData: [Customer] = [
        Customer(id: 1, name: "Foo", address: "Bar")
    ]
}

#endif
