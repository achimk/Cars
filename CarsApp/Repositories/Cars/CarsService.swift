//
//  CarsService.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

final class CarsService: CarsServiceType {
    let instance: CarsServiceType

    init() {
        let models = [
            CarModel(id: "1", name: "My Porsche", model: "Carrera GT", brand: "Porsche", year: 2004),
            CarModel(id: "2", name: "My Ferrari", model: "458 Italia", brand: "Ferrari", year: 2010),
            CarModel(id: "3", name: "My McLaren", model: "P1", brand: "McLaren", year: 2013)
        ]
        self.instance = InMemoryCarsServiceAdapter(models)
    }

    func requestCarsList() -> Observable<Array<CarType>> {
        return instance.requestCarsList()
    }

    func createCar(with model: CarCreateModel) -> Observable<Void> {
        return instance.createCar(with: model)
    }

    func requestCarDetails(using identity: CarIdentityModel) -> Observable<CarType> {
        return instance.requestCarDetails(using: identity)
    }
}
