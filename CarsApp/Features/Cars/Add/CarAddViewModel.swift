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

enum CarSaveError: Error {
    case invalidForm(ValidationErrors)
    case serviceError(CarsServiceError)
    case unknown(Error)
}

typealias CarSaveResult = Result<Void, CarSaveError>

protocol CarAddViewModelInputs {
    func save()
}

protocol CarAddViewModelOutputs {
    var onInputViewModels: Driver<Array<CarInputViewModelType>> { get }
    var onFormEnabled: Driver<Bool> { get }
    var onLoading: Driver<Bool> { get }
    var onSaveResult: Driver<CarSaveResult> { get }
}

protocol CarAddViewModelType {
    var inputs: CarAddViewModelInputs { get }
    var outputs: CarAddViewModelOutputs { get }
}

final class CarAddViewModel: CarAddViewModelType {
    fileprivate let signalSave = PublishSubject<Void>()
    fileprivate let signalRequest: ObservableProbe
    fileprivate let valueInputViewModels: Variable<Array<CarInputViewModelType>>
    fileprivate let driverFormEnabled: Driver<Bool>
    fileprivate let driverSaveResult: Driver<CarSaveResult>

    var inputs: CarAddViewModelInputs { return self }
    var outputs: CarAddViewModelOutputs { return self }

    init(service: CarAddServiceType,
         validators: CarInputValidatorsFactoryType,
         converter: CarInputConverter,
         shouldValidateForm: Bool = true) {

        let probe = ObservableProbe()
        signalRequest = probe

        // Prepare inputs

        let inputs: Array<CarInputViewModelType> = [
            CarInputViewModel(inputType: .name, converter: converter, validator: validators.createNameValidator()),
            CarInputViewModel(inputType: .brand, converter: converter, validator: validators.createBrandValidator()),
            CarInputViewModel(inputType: .model, converter: converter, validator: validators.createModelValidator()),
            CarInputViewModel(inputType: .year, converter: converter, validator: validators.createYearValidator())
        ]

        valueInputViewModels = Variable<Array<CarInputViewModelType>>(inputs)

        // Prepare form validation

        let isFormEnabled: Observable<Bool> = shouldValidateForm
            ? CarInputValidationOperation(inputs).asObservable()
            : Observable.just(true)


        driverFormEnabled = isFormEnabled
            .asDriver(onErrorDriveWith: Driver.never())

        // Prepare save operation

        let builder = CarStepCreateBuilder(
            validators: validators,
            converter: converter
        )

        let saveOperation = CarSaveResultOperation(
            service: service,
            builder: builder,
            inputs: inputs,
            probe: probe
        )

        driverSaveResult = signalSave
            .asObservable()
            .withLatestFrom(probe)
            .filter { !$0 }
            .withLatestFrom(isFormEnabled)
            .filter { $0 }
            .flatMapLatest { _ in saveOperation.asObservable() }
            .asDriver(onErrorDriveWith: Driver.never())
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

    var onLoading: Driver<Bool> {
        return signalRequest.asDriver()
    }

    var onSaveResult: Driver<CarSaveResult> {
        return driverSaveResult
    }
}
