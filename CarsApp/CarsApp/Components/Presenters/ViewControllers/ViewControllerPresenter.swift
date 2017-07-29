//
//  ViewControllerPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct ViewControllerPresenter: ViewControllerPresentable {
    let presentCallback: ((UIViewController) -> Void)

    init(_ callback: @escaping ((UIViewController) -> Void)) {
        self.presentCallback = callback
    }

    func present(_ viewController: UIViewController) {
        presentCallback(viewController)
    }
}
