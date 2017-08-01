//
//  CarsListRoute.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarsListRoute: Routable {
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

    func navigate(to location: LocationType, using presenter: ViewControllerPresenterType) throws {
        guard location.path == Navigation.Path.carsList.rawValue else { return }

        let flow = CarsListFlow(
            navigationService: navigationService,
            listService: listService,
            errorPresenter: errorPresenter
        )

        flow.present(using: presenter)
    }
}
