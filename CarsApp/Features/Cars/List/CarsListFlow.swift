//
//  CarsListFlow.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct CarsListFlow: FlowPresentable {
    let navigationService: NavigationServiceType
    let listService: CarsListServiceType
    let errorPresenter: ErrorPresenterType?

    init(navigationService: NavigationServiceType,
         listService: CarsListServiceType,
         errorPresenter: ErrorPresenterType?) {

        self.navigationService = navigationService
        self.listService = listService
        self.errorPresenter = errorPresenter
    }

    func present(using presenter: ViewControllerPresentable) {
        let navigation = navigationService
        let errorPresenter = ProxyErrorPresenter(self.errorPresenter)

        let onSelectCallback: ((CarType) -> Void) = { car in
            let location = Navigation.Route.carDetails(car.asIdentityModel()).asLocation()
            navigation.navigate(to: location, using: presenter)
        }

        let viewController = CarsListViewController(
            service: listService,
            errorPresenter: errorPresenter,
            onSelectCallback: onSelectCallback
        )

        if errorPresenter.proxy == nil {
            errorPresenter.proxy = RetryErrorPresenter.create(using: viewController)
        }

        viewController.title = NSLocalizedString("Cars List", comment: "List of cars title")
        
        presenter.present(viewController)
    }
    
}
