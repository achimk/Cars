//
//  CarAddFlow.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct CarAddFlow: FlowPresentable {
    private let addService: CarAddServiceType
    private let errorPresenter: ErrorPresenterType?
    private let onSaveCallback: ((Bool) -> Void)?

    init(addService: CarAddServiceType,
         errorPresenter: ErrorPresenterType?,
         onSaveCallback: ((Bool) -> Void)?) {

        self.addService = addService
        self.errorPresenter = errorPresenter
        self.onSaveCallback = onSaveCallback
    }

    func present(using presenter: ViewControllerNavigationType) {
        let errorPresenter = ProxyErrorPresenter(self.errorPresenter)

        let viewController = CarAddViewController(
            service: addService,
            errorPresenter: errorPresenter,
            onSaveCallback: onSaveCallback
        )

        if errorPresenter.proxy == nil {
            errorPresenter.proxy = AlertErrorPresenter.create(using: viewController)
        }

        viewController.title = NSLocalizedString("Add Car", comment: "Add new car title")

        presenter.present(viewController)
    }

}
