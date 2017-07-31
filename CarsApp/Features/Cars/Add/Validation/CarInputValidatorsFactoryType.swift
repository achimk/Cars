//
//  CarInputValidatorsFactoryType.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Validator

typealias CarInputValidator = ResultValidation<String>

enum CarInputValidationError: Error {
    case invalidName(String)
    case invalidBrand(String)
    case invalidModel(String)
    case invalidYear(String)
}

protocol CarInputValidatorsFactoryType {
    func createNameValidator() -> CarInputValidator
    func createBrandValidator() -> CarInputValidator
    func createModelValidator() -> CarInputValidator
    func createYearValidator() -> CarInputValidator
}
