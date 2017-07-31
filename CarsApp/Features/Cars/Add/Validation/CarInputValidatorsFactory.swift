//
//  CarInputValidatorsFactory.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result

struct CarInputValidatorsFactory: CarInputValidatorsFactoryType {

    init() { }

    func createNameValidator() -> CarInputValidator {
        let message = NSLocalizedString("Invalid name", comment: "Invalid name error")
        let error = CarInputValidationError.invalidName(message)
        let validator = Validation.isNotEmpty()

        return Result<String, CarInputValidationError>.createValidator(
            using: validator,
            error: error
        )
    }

    func createBrandValidator() -> CarInputValidator {
        let message = NSLocalizedString("Invalid brand name", comment: "Invalid brand error")
        let error = CarInputValidationError.invalidBrand(message)
        let validator = Validation.isNotEmpty()

        return Result<String, CarInputValidationError>.createValidator(
            using: validator,
            error: error
        )
    }

    func createModelValidator() -> CarInputValidator {
        let message = NSLocalizedString("Invalid brand name", comment: "Invalid brand error")
        let error = CarInputValidationError.invalidBrand(message)
        let validator = Validation.isNotEmpty()

        return Result<String, CarInputValidationError>.createValidator(
            using: validator,
            error: error
        )
    }

    func createYearValidator() -> CarInputValidator {
        let message = NSLocalizedString("Invalid brand name", comment: "Invalid brand error")
        let error = CarInputValidationError.invalidBrand(message)
        let validator = Validation.isNotEmpty()

        // FIXME: Add year format validator here, also this will require validators composition functionality!

        return Result<String, CarInputValidationError>.createValidator(
            using: validator,
            error: error
        )
    }
}
