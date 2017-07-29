//
//  CarCreateModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarCreateModel: Equatable {
    let name: String?
    let model: String?
    let brand: String?
    let year: Int?

    init(name: String?,
         model: String?,
         brand: String?,
         year: Int?) {

        self.name = name
        self.model = model
        self.brand = brand
        self.year = year
    }
}

func ==(lhs: CarCreateModel, rhs: CarCreateModel) -> Bool {
    return lhs.name == rhs.name
        && lhs.model == rhs.model
        && lhs.brand == rhs.brand
        && lhs.year == rhs.year
}
