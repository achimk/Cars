//
//  NavigationPresenterFactory.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct NavigationPresenterFactory: ViewControllerPresenterProducable {

    let window: UIWindow
    let navigationController: UINavigationController

    init(window: UIWindow? = nil, navigation: UINavigationController? = nil) {
        self.window = window ?? UIWindow()
        self.navigationController = navigation ?? UINavigationController()
    }

    func createPresenter() -> ViewControllerPresentable {
        let windowPresenter = WindowPresenter(window)
        let navigationPresenter = NavigationPresenter(navigationController, animated: true)

        return ViewControllerPresenter { viewController in
            let currentController = windowPresenter.window.rootViewController
            let navigationController = navigationPresenter.navigationController
            let hasNavigationAsRoot = (currentController === navigationController)

            if !hasNavigationAsRoot {
                windowPresenter.present(navigationController)
            }

            navigationPresenter.present(viewController)
        }
    }
}
