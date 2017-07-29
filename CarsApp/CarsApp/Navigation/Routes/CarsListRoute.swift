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

    init(navigationService: NavigationServiceType, listService: CarsListServiceType) {
        self.navigationService = navigationService
        self.listService = listService
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws {
        guard location.path == Navigation.Route.carsList.asPath() else { return }

        let flow = CarsListFlow(
            navigationService: navigationService,
            listService: listService
        )

        flow.present(using: presenter)
    }
}
