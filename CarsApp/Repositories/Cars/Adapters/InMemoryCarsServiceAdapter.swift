//
//  InMemoryCarsServiceAdapter.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

final class InMemoryCarsServiceAdapter: CarsServiceType {
    let service = InMemoryCarsService()

    init(_ models: Array<CarModel> = []) {
        service.models = models
    }

    func requestCarsList() -> Observable<Array<CarType>> {
        let service = self.service
        return Observable.just(
            service.models.map(CarsModelEntityMapper.from).flatMap { $0 }
        )
    }

    func createCar(with model: CarCreateModel) -> Observable<Void> {
        let service = self.service
        let operation = Observable.create({ (observer: AnyObserver<Void>) -> Disposable in

            let identifier = String(service.models.count.advanced(by: 1))
            let car = CarModel(
                id: identifier,
                name: model.name,
                model: model.model,
                brand: model.brand,
                year: model.year
            )

            service.models.append(car)

            observer.onNext()
            observer.onCompleted()

            return Disposables.create()
        })

        return operation
    }

    func requestCarDetails(using identity: CarIdentityModel) -> Observable<CarType> {
        let service = self.service
        let operation = Observable.create { (observer: AnyObserver<CarType>) -> Disposable in

            let model = service.models
                .filter { $0.id == identity.id }
                .first
                .map(CarsModelEntityMapper.from)


            if let model = model {
                observer.onNext(model)
                observer.onCompleted()
            } else {
                observer.onError(CarsServiceError.notFound)
            }

            return Disposables.create()
        }

        return operation
    }
}
