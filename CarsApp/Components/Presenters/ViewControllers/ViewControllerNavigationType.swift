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
}
