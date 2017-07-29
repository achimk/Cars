//
//  CarsListPresentationItem.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarsListItemPresentable: CarConvertible {
    var title: String { get }
    var subtitle: String { get }
}

struct CarsListPresentationItem: CarsListItemPresentable {
    let car: CarType

    var title: String {
        return car.name ?? ""
    }

    var subtitle: String {
        var items: Array<String> = []

        if let brand = car.brand {
            items.append(brand)
        }

        if let model = car.model {
            items.append(model)
        }

        if let year = CarsModelEntityMapper.year(from: car.manufactureDate) {
            items.append(String("(\(year))"))
        }

        return items.joined(separator: " ")
    }

    init(_ car: CarType) {
        self.car = car
    }

    func asCar() -> CarType {
        return car
    }
}
