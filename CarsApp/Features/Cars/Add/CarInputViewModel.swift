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

enum CarInputType: String {
    case name
    case model
    case brand
    case year

    func asPlaceholder() -> String {
        switch self {
        case .name: return NSLocalizedString("Name", comment: "Name placeholder input")
        case .model: return NSLocalizedString("Model", comment: "Model placeholder input")
        case .brand: return NSLocalizedString("Brand", comment: "Brand placeholder input")
        case .year: return NSLocalizedString("Year", comment: "Year placeholder input")
        }
    }
}

typealias CarInputResult = Result<String, ValidationErrors>

protocol CarInputViewModelInputs {
    func change(input text: String?)
    func accepts(create model: inout CarCreateModel)
}

protocol CarInputViewModelOutputs {
    var currentPlaceholder: String { get }
    var currentText: String { get }
    var onTextResult: Driver<CarInputResult> { get }
}

protocol CarInputViewModelType {
    var inputs: CarInputViewModelInputs { get }
    var outputs: CarInputViewModelOutputs { get }
}

final class CarInputViewModel: CarInputViewModelType {
    fileprivate let inputType: CarInputType
    fileprivate let converter: CarInputConverter
    fileprivate let valueInput = Variable<String?>(nil)
    fileprivate let driverTextResult: Driver<CarInputResult>

    let currentPlaceholder: String

    var inputs: CarInputViewModelInputs { return self }
    var outputs: CarInputViewModelOutputs { return self }

    init(inputType: CarInputType, converter: CarInputConverter, validator: @escaping CarInputValidator) {
        self.inputType = inputType
        self.converter = converter
        self.currentPlaceholder = inputType.asPlaceholder()
        self.driverTextResult = valueInput
            .asObservable()
            .map { validator(converter.run($0)) }
            .debug("---> \(inputType)")
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

    func accepts(create model: inout CarCreateModel) {
        switch inputType {
        case .name:
            model.name = currentText
        case .brand:
            model.brand = currentText
        case .model:
            model.model = currentText
        case .year:
//            model.year = currentText
            break
        }
    }
}

extension CarInputViewModel: CarInputViewModelOutputs {
    var currentText: String {
        return converter.run(valueInput.value)
    }

    var onTextResult: Driver<CarInputResult> {
        return driverTextResult
    }
}
