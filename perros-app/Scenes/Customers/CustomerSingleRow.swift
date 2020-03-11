//
//  CustomerSingleRow.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct CustomerSingleRow: View {
    let model: Customer
    
    var body: some View {
        HStack {
            Image("default-avatar").resizable().frame(width: 50, height: 50).cornerRadius(50)
            VStack(alignment: .leading) {
                Text(model.name)
                Text(model.address).font(.system(.caption))
            }
        }
    }
}
