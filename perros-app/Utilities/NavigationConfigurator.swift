//
//  NavigationConfigurator.swift
//  perros-app
//
//  Created by Alan Steiman on 22/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context _: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context _: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            configure(nc)
        }
    }
}
