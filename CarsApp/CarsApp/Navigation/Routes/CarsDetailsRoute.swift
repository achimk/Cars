//
//  CarsDetailsRoute.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarsDetailsRoute: Routable {
    let navigationService: NavigationServiceType

    init(navigationService: NavigationServiceType) {
        self.navigationService = navigationService
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws {
        throw RouteError.notFound(location)
    }
}
