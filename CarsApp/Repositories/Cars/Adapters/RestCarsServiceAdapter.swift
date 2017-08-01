//
//  RestCarsServiceAdapter.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class RestCarsServiceAdapter: CarsServiceType {
    private let service = RestCarsService()
    private let builder = RestCarsEndpointBuilder()
    private let variableList = Variable<Array<CarType>>([])

    init() { }

    func requestCarsList() -> Observable<Array<CarType>> {
        return ListCarsTask(dispatcher: service, endpointBuilder: builder)
            .perform()
            .map { $0.map(CarModelResponseMapper.from).flatMap { $0 } }
            .do(onNext: { [weak self] (models) in
                self?.variableList.value = models
            })
    }

    func requestCarDetails(using identity: CarIdentityModel) -> Observable<CarType> {
        return variableList.asObservable()
            .map { (models) -> CarType in
                let found = models.filter { $0.identifier == identity.id }.first

                switch found {
                case .some(let model): return model
                case .none: throw CarsServiceError.notFound
                }
            }
    }

    func createCar(with model: CarCreateModel) -> Observable<Void> {
        let body = CarModelResponseMapper.from(model)

        return AddCarTask(dispatcher: service, endpointBuilder: builder)
            .perform(body)
            .map { _ in return () }
    }
}
