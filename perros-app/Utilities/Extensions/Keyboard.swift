//
//  Keyboard.swift
//  perros-app
//
//  Created by Alan Steiman on 18/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import SwiftUI

struct KeyboardResponsiveModifier: ViewModifier {
    @State private var offset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
                    let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                    self.offset = height - (bottomInset ?? 0)
                }

                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    self.offset = 0
                }
            }
    }
}

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
        return modifier(KeyboardResponsiveModifier())
    }
}
