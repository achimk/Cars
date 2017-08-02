//
//  CarsModelEntityMapper.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarsModelEntityMapper {

    static func from(_ model: CarModel) -> CarType {
        return Car(
            identifier: model.id,
            name: model.name,
            model: model.model,
            brand: model.brand,
            manufactureDate: date(from: model.year)
        )
    }

    static func from(_ car: CarType) -> CarModel {
        return CarModel(
            id: car.identifier,
            name: car.name,
            model: car.model,
            brand: car.brand,
            year: year(from: car.manufactureDate)
        )
    }

    static func date(from year: String?) -> Date? {
        guard let year = year else { return nil }
        return CarManufactureFormatter.dateFormatter.date(from: "\(year)-01-01 00:00:00 +0000")
    }

    static func year(from date: Date?) -> String? {
        guard let date = date else { return nil }
        return CarManufactureFormatter.yearFormatter.string(from: date)
    }
}
