//
//  NavigationService.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct NavigationService: NavigationServiceType, NavigationServiceFactoryType {
    let router: Router

    static func create() -> NavigationServiceType {

        // Select backend service by environment

        let service: CarsServiceType
        switch App.environment {
        case .develop:
            service = CarsService(InMemoryCarsServiceAdapter())
        case .production:
            service = CarsService(RestCarsServiceAdapter())
        }

        let navigator = NavigationServiceProxy()
        var router = Router()

        // Source of all routes available in App

        router.routes[Navigation.Path.carAdd.rawValue] = CarAddRoute(
            addService: service,
            errorPresenter: nil
        )

        router.routes[Navigation.Path.carDetails.rawValue] = CarDetailsRoute(
            detailsService: service,
            errorPresenter: nil
        )

        router.routes[Navigation.Path.carsList.rawValue] = CarsListRoute(
            navigationService: navigator,
            listService: service,
            errorPresenter: nil
        )

        navigator.proxy = NavigationService(router)

        return navigator
    }

    init(_ router: Router) {
        self.router = router
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresenterType) {
        router.navigate(to: location, using: presenter)
    }
}

private final class NavigationServiceProxy: NavigationServiceType {
    var proxy: NavigationServiceType?

    init() { }

    func navigate(to location: LocationType, using presenter: ViewControllerPresenterType) {
        proxy?.navigate(to: location, using: presenter)
    }
}
