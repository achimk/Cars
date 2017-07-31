//
//  CarAddViewModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result

typealias CarSaveResult = Result<Void, CarsServiceError>

protocol CarAddViewModelInputs {
    func save()
}

protocol CarAddViewModelOutputs {
    var onInputViewModels: Driver<Array<CarInputViewModelType>> { get }
    var onFormEnabled: Driver<Bool> { get }
    var onSaveResult: Driver<CarSaveResult> { get }
}

protocol CarAddViewModelType {
    var inputs: CarAddViewModelInputs { get }
    var outputs: CarAddViewModelOutputs { get }
}

final class CarAddViewModel: CarAddViewModelType {
    fileprivate let signalSave = PublishSubject<Void>()
    fileprivate let valueInputViewModels: Variable<Array<CarInputViewModelType>>
    fileprivate let driverFormEnabled: Driver<Bool>

    var inputs: CarAddViewModelInputs { return self }
    var outputs: CarAddViewModelOutputs { return self }

    init(service: CarAddServiceType,
         validators: CarInputValidatorsFactoryType,
         converter: CarInputConverter) {

        let inputs: Array<CarInputViewModelType> = [
            CarInputViewModel(inputType: .name, converter: converter, validator: validators.createNameValidator()),
            CarInputViewModel(inputType: .brand, converter: converter, validator: validators.createBrandValidator()),
            CarInputViewModel(inputType: .model, converter: converter, validator: validators.createModelValidator()),
            CarInputViewModel(inputType: .year, converter: converter, validator: validators.createYearValidator())
        ]

        valueInputViewModels = Variable<Array<CarInputViewModelType>>(inputs)

        let signals = inputs.map {
            $0.outputs.onTextResult.asObservable().map { $0.isSuccess }
        }

        let isFormEnabled = Observable.combineLatest(signals) { (items) -> Bool in
            return items.reduce(true, { (result, value) -> Bool in
                return result && value
            })
        }.distinctUntilChanged()

//        let rs = Observable.combineLatest(signals[0], signals[1], signals[2], signals[3]) { (input1, input2, input3, input4) -> Bool in
//            return false
//        }

//        let isFormEnabled = Observable.from(inputs.map {
//                $0.outputs.onTextResult.asObservable().map { $0.isSuccess }
//            })
//            .merge()
//            .distinctUntilChanged()


        driverFormEnabled = isFormEnabled
            .asDriver(onErrorDriveWith: Driver.never())

//        signalSave.asObservable()
//            .withLatestFrom(isFormEnabled)
//            .filter { $0 }
//            .flatMapLatest { _ in
//                return service.createCar(with: <#T##CarCreateModel#>)
//            }
    }

    deinit {
        print("[*] \(type(of: self)): \(#function)")
    }
}

extension CarAddViewModel: CarAddViewModelInputs {
    func save() {
        signalSave.onNext()
    }
}

extension CarAddViewModel: CarAddViewModelOutputs {
    var onInputViewModels: Driver<Array<CarInputViewModelType>> {
        return valueInputViewModels.asDriver()
    }

    var onFormEnabled: Driver<Bool> {
        return driverFormEnabled
    }

    var onSaveResult: Driver<CarSaveResult> {
        return Driver.empty()
    }
}
