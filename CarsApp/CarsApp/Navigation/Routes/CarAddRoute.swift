//
//  CarAddRoute.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarAddRoute: Routable {
    let navigationService: NavigationServiceType

    init(navigationService: NavigationServiceType) {
        self.navigationService = navigationService
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws {

        // FIXME: Implement!

        let flow = CarAddFlow()
        flow.present(using: presenter)
    }
}
