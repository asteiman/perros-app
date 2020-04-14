//
//  SearchBarView.swift
//  perros-app
//
//  Created by Alan Steiman on 08/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var sortAsc: Bool
    @State private var showCancelButton: Bool = false
    var onCommit: () -> Void = { print("onCommit") }

    var body: some View {
        VStack {
            Spacer().frame(width: 1, height: 10)
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")

                    // Search text field
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                            Text("Search")
                        }
                        TextField("", text: $searchText, onEditingChanged: { _ in
                            self.showCancelButton = true
                        }, onCommit: onCommit).foregroundColor(.primary)
                    }
                    // Clear button
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary) // For magnifying glass and placeholder test
                .background(Color(.tertiarySystemFill))
                .cornerRadius(10.0)

                if showCancelButton {
                    // Cancel button
                    Button("Cancel") {
                        UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                        self.searchText = ""
                        self.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                } else {
                    Button(action: {
                        self.sortAsc.toggle()
                    }) {
                        Image(systemName: "arrow.up.arrow.down").foregroundColor(Color(ColorKit.danube))
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton)
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var text = ""
    @State static var sortAsc = true
    static var previews: some View {
        SearchBarView(searchText: $text, sortAsc: $sortAsc)
    }
}
