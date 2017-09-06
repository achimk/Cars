//
//  ModalPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 28/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct ModalPresenter: ViewControllerNavigationType {
    let parent: ViewControllerNavigationType
    let animated: Bool

    init(parent: ViewControllerNavigationType, animated: Bool = true) {
        self.parent = parent
        self.animated = animated
    }

    func present(_ viewController: UIViewController) {
        guard let firstViewController = parent.firstChainController() else { return }
        firstViewController.present(viewController, animated: animated, completion: nil)
    }

    func dismiss() {
        guard let firstViewController = parent.firstChainController() else { return }
        firstViewController.dismiss(animated: animated, completion: nil)
    }
}
