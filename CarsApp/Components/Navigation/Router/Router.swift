//
//  Router.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct Router: Routable {
    var routes = Dictionary<String, Routable>()
    var errorRouteHandler: ErrorRoutable?

    init() { }

    func navigate(to location: LocationType, using presenter: ViewControllerNavigationType) {
        guard let route = routes[location.path] else {
            errorRouteHandler?.handle(routeError: RouteError.notFound(location), using: presenter)
            return
        }

        do {
            try route.navigate(to: location, using: presenter)
        } catch let error as RouteError {
            errorRouteHandler?.handle(routeError: error, using: presenter)
        } catch let error {
            errorRouteHandler?.handle(routeError: RouteError.unknown(location, error), using: presenter)
        }
    }
}
