//
//  Car.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct Car: CarType {
    var identifier: String
    var name: String?
    var model: String?
    var brand: String?
    var manufactureDate: Date?

    init(identifier: String,
         name: String?,
         model: String?,
         brand: String?,
         manufactureDate: Date?) {

        self.identifier = identifier
        self.name = name
        self.model = model
        self.brand = brand
        self.manufactureDate = manufactureDate
    }
}
