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

    init(_ instance: CarsServiceType) {
        self.instance = instance
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
