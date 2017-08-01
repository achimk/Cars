//
//  CarSaveResultOperation.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

struct CarSaveResultOperation: ObservableConvertibleType {
    private let service: CarAddServiceType
    private let builder: CarStepCreateBuilderType
    private let inputs: Array<CarInputViewModelType>
    private let probe: ObservableProbe

    init(service: CarAddServiceType,
         builder: CarStepCreateBuilderType,
         inputs: Array<CarInputViewModelType>,
         probe: ObservableProbe) {

        self.service = service
        self.builder = builder
        self.inputs = inputs
        self.probe = probe
    }

    func asObservable() -> Observable<CarSaveResult> {
        let operation = self
        let probe = self.probe

        print("-> create observable")

        return createModelObserverable()
            .flatMapLatest { operation.createServiceObservable(with: $0, probe: probe) }
            .map { CarSaveResult.success() }
            .catchError { operation.createResult(with: $0) }
    }

    private func createModelObserverable() -> Observable<CarCreateModel> {
        let builder = self.builder
        let inputs = self.inputs

        return Observable.create { (observer: AnyObserver<CarCreateModel>) -> Disposable in
            builder.prepareForUse()
            inputs.forEach { $0.inputs.accept(builder) }

            do {
                let result = try builder.build()
                observer.onNext(result)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    private func createServiceObservable(with model: CarCreateModel, probe: ObservableProbe) -> Observable<Void> {
        return service
            .createCar(with: model)
            .take(1)
            .trackActivity(probe)
    }

    private func createResult(with error: Error) -> Observable<CarSaveResult> {
        let result: CarSaveResult

        switch error {
        case let error as ValidationErrors:
            print("# error: \(error.errors[0])")
            result = CarSaveResult.failure(CarSaveError.invalidForm(error))

        case let error as CarsServiceError:
            print("# error: \(error)")
            result = CarSaveResult.failure(CarSaveError.serviceError(error))

        default:
            print("# error: \(error)")
            result = CarSaveResult.failure(CarSaveError.unknown(error))
        }

        return Observable.just(result)
    }
}
