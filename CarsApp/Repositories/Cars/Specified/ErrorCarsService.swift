//
//  ErrorCarsService.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

struct ErrorCarsService: CarsServiceType {
    let error: CarsServiceError

    init(error: CarsServiceError = .cantConnect) {
        self.error = error
    }

    func requestCarsList() -> Observable<Array<CarType>> {
        return Observable.error(error)
    }

    func requestCarDetails(using identity: CarIdentityModel) -> Observable<CarType> {
        return Observable.error(error)
    }

    func createCar(with model: CarCreateModel) -> Observable<Void> {
        return Observable.error(error)
    }
}
