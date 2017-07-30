//
//  CarDetailsPresentationItem.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarDetailsItemPresentable: CarConvertible {
    var parameter: String { get }
    var value: String { get }
}

struct CarDetailsPresentationItem: CarDetailsItemPresentable {
    let car: CarType
    let param: CarDetailsParameter

    var parameter: String {
        switch param {
        case .name:
            return NSLocalizedString("Name:", comment: "Name parameter")

        case .model:
            return NSLocalizedString("Model:", comment: "Model parameter")

        case .brand:
            return NSLocalizedString("Brand:", comment: "Brand parameter")

        case .year:
            return NSLocalizedString("Year:", comment: "Year parameter")
        }
    }

    var value: String {
        switch param {
        case .name:
            return car.name ?? ""

        case .model:
            return car.model ?? ""

        case .brand:
            return car.brand ?? ""

        case .year:
            if let year = CarsModelEntityMapper.year(from: car.manufactureDate) {
                return "\(year)"
            } else {
                return ""
            }
        }
    }

    init(car: CarType, param: CarDetailsParameter) {
        self.car = car
        self.param = param
    }

    func asCar() -> CarType {
        return car
    }
}
