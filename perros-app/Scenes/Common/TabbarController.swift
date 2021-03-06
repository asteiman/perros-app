//
//  TabbarController.swift
//  perros-app
//
//  Created by Alan Steiman on 18/03/2020.
//  Copyright © 2020 Alan Steiman. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct UIKitTabView: View {
    var viewControllers: [UIHostingController<AnyView>]

    init(_ tabs: [Tab]) {
        viewControllers = tabs.map {
            let host = UIHostingController(rootView: $0.view)
            host.tabBarItem = $0.barItem
            return host
        }
    }

    var body: some View {
        TabBarController(controllers: viewControllers)
            .edgesIgnoringSafeArea(.all)
    }

    struct Tab {
        var view: AnyView
        var barItem: UITabBarItem

        init<V: View>(view: V, barItem: UITabBarItem) {
            self.view = AnyView(view)
            self.barItem = barItem
        }
    }
}

struct TabBarController: UIViewControllerRepresentable {
    func updateUIViewController(_: UITabBarController, context _: UIViewControllerRepresentableContext<TabBarController>) {}

    var controllers: [UIViewController]

    func makeUIViewController(context _: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .white
        tabBarController.tabBar.barTintColor = ColorKit.danube
        return tabBarController
    }
}
