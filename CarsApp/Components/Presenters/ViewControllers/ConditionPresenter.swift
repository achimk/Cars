//
//  ConditionPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct ConditionPresenter: ViewControllerNavigationType {
    let parent: ViewControllerNavigationType?
    let presentCallback: ((UIViewController) -> Void)
    let dismissCallback: ((Void) -> Void)

    static func present(_ callback: @escaping ((UIViewController) -> Void)) -> ViewControllerNavigationType {
        return ConditionPresenter(onPresent: callback, onDismiss: { })
    }

    static func dismiss(_ callback: @escaping ((Void) -> Void)) -> ViewControllerNavigationType {
        return ConditionPresenter(onPresent: { _ in }, onDismiss: callback)
    }

    init(parent: ViewControllerNavigationType? = nil,
         onPresent: @escaping ((UIViewController) -> Void),
         onDismiss: @escaping ((Void) -> Void)) {

        self.parent = parent
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
