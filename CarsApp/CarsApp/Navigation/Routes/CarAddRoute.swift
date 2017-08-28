//
//  CarAddRoute.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarAddRoutePayload {
    let completion: ((Bool) -> Void)?
}

struct CarAddRoute: Routable {
    let addService: CarAddServiceType
    let errorPresenter: ErrorPresenterType?

    init(addService: CarAddServiceType,
         errorPresenter: ErrorPresenterType?) {

        self.addService = addService
        self.errorPresenter = errorPresenter
    }

    func navigate(to location: LocationType, using presenter: ViewControllerNavigationType) throws {
        guard location.path == Navigation.Path.carAdd.rawValue else { return }
        let payload = location.payload as? CarAddRoutePayload

        let flow = CarAddFlow(
            addService: addService,
            errorPresenter: errorPresenter,
            onSaveCallback: payload?.completion
        )
        
        flow.present(using: presenter)
    }
}
