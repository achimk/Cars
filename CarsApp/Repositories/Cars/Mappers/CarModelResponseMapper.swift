//
//  CarModelResponseMapper.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarModelResponseMapper {

    static func from(_ model: CarModelResponse) -> CarType? {
        guard let id = model.id else { return nil }

        return Car(
            identifier: id,
            name: model.name,
            model: model.model,
            brand: model.brand,
            manufactureDate: date(from: model.year)
        )
    }

    static func from(_ model: CarCreateModel) -> CarBodyParameters {
        return CarBodyParameters(
            name: model.name,
            brand: model.brand,
            model: model.model,
            year: String(model.year) ?? ""
        )
    }

    static func date(from year: String?) -> Date? {
        guard let year = year else { return nil }
        return CarManufactureFormatter.dateFormatter.date(from: "\(year)-01-01 00:00:00 +0000")
    }
}
