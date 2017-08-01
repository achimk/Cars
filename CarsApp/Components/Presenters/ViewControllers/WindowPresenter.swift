//
//  WindowPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct WindowPresenter: ViewControllerPresenterType {
    let window: UIWindow

    init(_ window: UIWindow) {
        self.window = window
    }

    func present(_ viewController: UIViewController) {
        window.rootViewController = viewController

        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }

    func dismiss() {
        window.rootViewController = nil
    }
}
