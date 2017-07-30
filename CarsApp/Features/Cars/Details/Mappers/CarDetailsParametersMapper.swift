//
//  CarDetailsParametersMapper.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

enum CarDetailsParameter: String {
    case name
    case model
    case brand
    case year
}

struct CarDetailsParametersMapper {

    static func map(_ car: CarType) -> Array<CarDetailsItemPresentable> {
        return [
            CarDetailsPresentationItem(car: car, param: .name),
            CarDetailsPresentationItem(car: car, param: .model),
            CarDetailsPresentationItem(car: car, param: .brand),
            CarDetailsPresentationItem(car: car, param: .year)
        ]
    }
}
