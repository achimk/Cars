//
//  CarInputViewModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result

typealias CarInputResult = Result<String, ValidationErrors>

protocol CarInputViewModelInputs: CarStepCreateAcceptable {
    func change(input text: String?)
}

protocol CarInputViewModelOutputs {
    var inputType: CarInputType { get }
    var currentPlaceholder: String { get }
    var currentText: String? { get }
    var onTextResult: Driver<CarInputResult> { get }
}

protocol CarInputViewModelType {
    var inputs: CarInputViewModelInputs { get }
    var outputs: CarInputViewModelOutputs { get }
}

final class CarInputViewModel: CarInputViewModelType {

    fileprivate let converter: CarInputConverter
    fileprivate let valueInput = Variable<String?>(nil)
    fileprivate let driverTextResult: Driver<CarInputResult>

    let inputType: CarInputType
    let currentPlaceholder: String

    var inputs: CarInputViewModelInputs { return self }
    var outputs: CarInputViewModelOutputs { return self }

    init(inputType: CarInputType,
         converter: CarInputConverter,
         validator: @escaping CarInputValidator) {

        self.inputType = inputType
        self.converter = converter
        self.currentPlaceholder = inputType.asPlaceholder()
        self.driverTextResult = valueInput
            .asObservable()
            .map { validator(converter.run($0)) }
            .asDriver(onErrorDriveWith: Driver.never())
    }

    deinit {
        print("[*] \(type(of: self)): \(#function)")
    }
}

extension CarInputViewModel: CarInputViewModelInputs {
    func change(input text: String?) {
        valueInput.value = text
    }

    func accept(_ stepCreate: CarStepCreateConfigurable) {
        switch inputType {
        case .name:
            stepCreate.set(name: currentText)

        case .brand:
            stepCreate.set(brand: currentText)

        case .model:
            stepCreate.set(model: currentText)

        case .year:
            stepCreate.set(year: currentText)
        }
    }
}

extension CarInputViewModel: CarInputViewModelOutputs {
    var currentText: String? {
        return valueInput.value
    }

    var onTextResult: Driver<CarInputResult> {
        return driverTextResult
    }
}
