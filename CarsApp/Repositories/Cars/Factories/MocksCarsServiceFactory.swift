//
//  MocksCarsServiceFactory.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct MocksCarsServiceFactory: CarsServiceFactoryType {

    static func create() -> CarsServiceType {
        let models = [
            CarModel(id: "1", name: "My Porsche", model: "Carrera GT", brand: "Porsche", year: 2004),
            CarModel(id: "2", name: "My Ferrari", model: "458 Italia", brand: "Ferrari", year: 2010),
            CarModel(id: "3", name: "My McLaren", model: "P1", brand: "McLaren", year: 2013)
        ]

        return InMemoryCarsServiceAdapter(models)
    }
}
