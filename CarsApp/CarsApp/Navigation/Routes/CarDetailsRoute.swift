//
//  CarDetailsRoute.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarDetailsRoutePayload {
    let identity: CarIdentityModel
}

struct CarDetailsRoute: Routable {
    let detailsService: CarDetailsServiceType
    let errorPresenter: ErrorPresenterType?

    init(detailsService: CarDetailsServiceType,
         errorPresenter: ErrorPresenterType?) {

        self.detailsService = detailsService
        self.errorPresenter = errorPresenter
    }

    func navigate(to location: LocationType, using presenter: ViewControllerPresentable) throws {
        guard location.path == Navigation.Path.carDetails.rawValue else { return }
        guard let payload = location.payload as? CarDetailsRoutePayload else { return }

        let flow = CarDetailsFlow(
            identity: payload.identity,
            detailsService: detailsService,
            errorPresenter: errorPresenter
        )

        flow.present(using: presenter)
    }
}
