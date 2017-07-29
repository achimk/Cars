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
        let navigator = NavigationServiceProxy()
        var router = Router()

        router.routes[Navigation.Route.carsList.asPath()] = CarsListRoute(
            navigationService: navigator
        )

        router.routes[Navigation.Route.carAdd.asPath()] = CarAddRoute(
            navigationService: navigator
        )

        router.routes[Navigation.Route.carDetails.asPath()] = CarDetailsRoute(
            navigationService: navigator
        )

        navigator.proxy = NavigationService(router)

        return navigator

    }

    init(_ router: Router) {
        self.router = router
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) {
        router.navigate(to: location, using: presenter)
    }
}

private final class NavigationServiceProxy: NavigationServiceType {
    var proxy: NavigationServiceType?

    init() { }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) {
        proxy?.navigate(to: location, using: presenter)
    }
}
