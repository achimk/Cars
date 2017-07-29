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
        case carsAdd
        case carsDetails
    }
}

extension Navigation.Route {

    func asPath() -> String {
        switch self {
        case .carsList: return "carsList"
        case .carsAdd: return "carsAdd"
        case .carsDetails: return "carsDetails"
        }
    }

    func asLocation() -> LocationType {
        switch self {
        case .carsList:
            return Location(scheme: Navigation.scheme, path: asPath())
        case .carsAdd:
            return Location(scheme: Navigation.scheme, path: asPath())
        case .carsDetails:
            return Location(scheme: Navigation.scheme, path: asPath())
        }
    }
}
