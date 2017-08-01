//
//  ConditionPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct ConditionPresenter: ViewControllerPresenterType {
    let presentCallback: ((UIViewController) -> Void)
    let dismissCallback: ((Void) -> Void)

    static func present(_ callback: @escaping ((UIViewController) -> Void)) -> ViewControllerPresenterType {
        return ConditionPresenter(onPresent: callback, onDismiss: { })
    }

    static func dismiss(_ callback: @escaping ((Void) -> Void)) -> ViewControllerPresenterType {
        return ConditionPresenter(onPresent: { _ in }, onDismiss: callback)
    }

    init(onPresent: @escaping ((UIViewController) -> Void),
         onDismiss: @escaping ((Void) -> Void)) {

        self.presentCallback = onPresent
        self.dismissCallback = onDismiss
    }

    func present(_ viewController: UIViewController) {
        presentCallback(viewController)
    }

    func dismiss() {
        dismissCallback()
    }

}
