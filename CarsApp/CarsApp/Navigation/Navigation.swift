//
//  Navigation.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

// MARK: Navigation Namespace

struct Navigation {

    // Default scheme used in project
    static let scheme: String = "carsapp"

    // Default routes used in project
    enum Route {
        case carsList
        case carAdd(CarAddRoutePayload)
        case carDetails(CarDetailsRoutePayload)
    }

    // Default paths used in project to identify routes
    enum Path: String {
        case carsList
        case carAdd
        case carDetails
    }
}

extension Navigation.Route {

    func asPath() -> Navigation.Path {
        switch self {
        case .carsList: return Navigation.Path.carsList
        case .carAdd: return Navigation.Path.carAdd
        case .carDetails: return Navigation.Path.carDetails
        }
    }

    func asLocation() -> LocationType {
        switch self {
        case .carsList:
            return Location(scheme: Navigation.scheme, path: asPath().rawValue)
        case .carAdd(let payload):
            return Location(scheme: Navigation.scheme, path: asPath().rawValue, payload: payload)
        case .carDetails(let payload):
            return Location(scheme: Navigation.scheme, path: asPath().rawValue, payload: payload)
        }
    }
}
