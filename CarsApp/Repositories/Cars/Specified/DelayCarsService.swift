//
//  DelayCarsService.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

struct DelayCarsService: CarsServiceType {
    let service: CarsServiceType
    let delay: RxTimeInterval

    init(service: CarsServiceType, delay: RxTimeInterval = 1) {
        self.service = service
        self.delay = delay
    }

    func requestCarsList() -> Observable<Array<CarType>> {
        return service.requestCarsList().delay(delay, scheduler: MainScheduler.asyncInstance)
    }

    func requestCarDetails(using identity: CarIdentityModel) -> Observable<CarType> {
        return service.requestCarDetails(using: identity).delay(delay, scheduler: MainScheduler.asyncInstance)
    }

    func createCar(with model: CarCreateModel) -> Observable<Void> {
        return service.createCar(with: model).delay(delay, scheduler: MainScheduler.asyncInstance)
    }

}
