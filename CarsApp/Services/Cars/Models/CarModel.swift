//
//  CarModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarModel {
    let id: String
    let name: String?
    let model: String?
    let brand: String?
    let year: Int?

    init(id: String,
         name: String?,
         model: String?,
         brand: String?,
         year: Int?) {

        self.id = id
        self.name = name
        self.model = model
        self.brand = brand
        self.year = year
    }
}
