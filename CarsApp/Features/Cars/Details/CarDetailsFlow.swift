//
//  CarDetailsFlow.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct CarDetailsFlow: FlowPresentable {

    init() {

        // FIXME: Implement

    }

    func present(using presenter: ViewControllerPresentable) {

        // FIXME: Implement

        let viewController = UIViewController()
        viewController.title = "Details"
        presenter.present(viewController)
    }
    
}