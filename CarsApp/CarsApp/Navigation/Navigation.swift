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
        case carAdd
        case carDetails
    }
}

extension Navigation.Route {

    func asPath() -> String {
        switch self {
        case .carsList: return "carsList"
        case .carAdd: return "carAdd"
        case .carDetails: return "carDetails"
        }
    }

    func asLocation() -> LocationType {
        switch self {
        case .carsList:
            return Location(scheme: Navigation.scheme, path: asPath())
        case .carAdd:
            return Location(scheme: Navigation.scheme, path: asPath())
        case .carDetails:
            return Location(scheme: Navigation.scheme, path: asPath())
        }
    }
}
