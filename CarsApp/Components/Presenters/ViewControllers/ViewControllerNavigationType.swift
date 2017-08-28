//
//  ViewControllerNavigationType.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerPresentable {
    func present(_ viewController: UIViewController)
}

protocol ViewControllerDismissible {
    func dismiss()
}

protocol ViewControllerNavigationType: ViewControllerPresentable, ViewControllerDismissible {
    var parent: ViewControllerNavigationType? { get }
    var viewController: UIViewController? { get }
}

extension ViewControllerNavigationType {
    var parent: ViewControllerNavigationType? { return nil }
    var viewController: UIViewController? { return nil }

    final func root() -> ViewControllerNavigationType {
        return parent?.root() ?? self
    }

    final func first() -> UIViewController? {
        for navigator in enumerated() {
            if let viewController = navigator.viewController {
                return viewController
            }
        }
        return nil
    }

    final func last() -> UIViewController? {
        var viewController: UIViewController?
        for navigator in enumerated() {
            if navigator.viewController != nil {
                viewController = navigator.viewController
            }
        }
        return viewController
    }

    final func enumerated() -> AnyIterator<ViewControllerNavigationType> {
        var current: ViewControllerNavigationType? = ConditionPresenter(
            parent: self,
            onPresent: { _ in },
            onDismiss: { }
        )

        return AnyIterator<ViewControllerNavigationType> {
            current = current?.parent
            return current
        }
    }
}

