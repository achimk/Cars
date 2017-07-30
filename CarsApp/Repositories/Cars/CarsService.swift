//
//  CarsService.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

final class CarsService: CarsServiceType, CarsServiceFactoryType {
    let instance: CarsServiceType

    static func create() -> CarsServiceType {
        return CarsService()
    }

    init() {
        self.instance = InMemoryCarsServiceAdapter()
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
