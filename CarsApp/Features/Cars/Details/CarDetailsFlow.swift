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
    private let identity: CarIdentityModel
    private let detailsService: CarDetailsServiceType
    private let errorPresenter: ErrorPresenterType?

    init(identity: CarIdentityModel,
         detailsService: CarDetailsServiceType,
         errorPresenter: ErrorPresenterType?) {

        self.identity = identity
        self.detailsService = detailsService
        self.errorPresenter = errorPresenter
    }

    func present(using presenter: ViewControllerPresenterType) {
        let errorPresenter = ProxyErrorPresenter(self.errorPresenter)

        let viewController = CarDetailsViewController(
            identity: identity,
            service: detailsService,
            errorPresenter: errorPresenter
        )

        if errorPresenter.proxy == nil {
            errorPresenter.proxy = RetryErrorPresenter.create(using: viewController)
        }

        viewController.title = NSLocalizedString("Car Details", comment: "Details of the car title")
        
        presenter.present(viewController)
    }
    
}
