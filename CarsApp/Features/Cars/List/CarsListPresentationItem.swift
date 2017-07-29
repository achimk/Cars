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
        return "\(car.brand ?? "") \(car.model ?? "") (\(car.manufactureDate?.description ?? ""))"
    }

    init(_ car: CarType) {
        self.car = car
    }

    func asCar() -> CarType {
        return car
    }
}
