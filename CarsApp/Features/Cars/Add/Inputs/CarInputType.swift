//
//  CarInputType.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

enum CarInputType: String {
    case name
    case model
    case brand
    case year

    func asPlaceholder() -> String {
        switch self {
        case .name: return NSLocalizedString("Name", comment: "Name placeholder input")
        case .model: return NSLocalizedString("Model", comment: "Model placeholder input")
        case .brand: return NSLocalizedString("Brand", comment: "Brand placeholder input")
        case .year: return NSLocalizedString("Year", comment: "Year placeholder input")
        }
    }
}
