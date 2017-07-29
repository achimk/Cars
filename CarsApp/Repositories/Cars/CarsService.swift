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

    init() {

    }

    func requestCarsList() -> Observable<Array<CarType>> {
        return Observable.empty()
    }

    func createCar(with entity: CarType) -> Observable<Void> {
        return Observable.empty()
    }

    func requestCarDetails(using identifier: String) -> Observable<CarType> {
        return Observable.empty()
    }
}
