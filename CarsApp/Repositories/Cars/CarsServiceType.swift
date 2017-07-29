//
//  CarsServiceType.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

protocol CarDetailsServiceType {
    func requestCarDetails(using identity: CarIdentityModel) -> Observable<CarType>
}

protocol CarAddServiceType {
    func createCar(with model: CarCreateModel) -> Observable<Void>
}

protocol CarsListServiceType {
    func requestCarsList() -> Observable<Array<CarType>>
}

protocol CarsServiceType: CarsListServiceType, CarAddServiceType, CarDetailsServiceType {
    
}
