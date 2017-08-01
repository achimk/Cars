//
//  NavigationPresenterFactory.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct NavigationPresenterFactory: NavigationPresenterFactoryType {
    let window: UIWindow
    let navigationController: UINavigationController

    init(window: UIWindow? = nil, navigation: UINavigationController? = nil) {
        self.window = window ?? UIWindow()
        self.navigationController = navigation ?? UINavigationController()
    }

    func createPresenter() -> ViewControllerPresenterType {
        let windowPresenter = WindowPresenter(window)
        let navigationPresenter = NavigationPresenter(navigationController, animated: true)

        let onPresent: ((UIViewController) -> Void) = { viewController in
            let currentController = windowPresenter.window.rootViewController
            let navigationController = navigationPresenter.navigationController
            let hasNavigationAsRoot = (currentController === navigationController)

            if !hasNavigationAsRoot {
                windowPresenter.present(navigationController)
            }

            navigationPresenter.present(viewController)
        }

        let onDismiss: ((Void) -> Void) = {
            navigationPresenter.dismiss()
        }

        return ConditionPresenter(onPresent: onPresent, onDismiss: onDismiss)
    }
}
