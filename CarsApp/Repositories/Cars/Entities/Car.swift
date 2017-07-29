//
//  Car.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct Car: CarType {
    let identifier: String
    let name: String
    let model: String
    let brand: String
    let manufactureDate: Date

    init(identifier: String,
         name: String,
         model: String,
         brand: String,
         manufactureDate: Date) {

        self.identifier = identifier
        self.name = name
        self.model = model
        self.brand = brand
        self.manufactureDate = manufactureDate
    }
}
