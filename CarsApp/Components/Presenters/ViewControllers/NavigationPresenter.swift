//
//  NavigationPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct NavigationPresenter: ViewControllerPresenterType {
    let navigationController: UINavigationController
    let animated: Bool

    init(_ navigationController: UINavigationController, animated: Bool = true) {
        self.navigationController = navigationController
        self.animated = animated
    }

    func present(_ viewController: UIViewController) {
        let shouldAnimate = navigationController.viewControllers.count > 0 && animated
        navigationController.pushViewController(viewController, animated: shouldAnimate)
    }

    func dismiss() {
        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: animated)
        } else {
            navigationController.viewControllers = []
        }
    }
}
