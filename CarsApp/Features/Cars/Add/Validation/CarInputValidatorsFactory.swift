//
//  CarInputValidatorsFactory.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result
import Validator

struct CarInputValidatorsFactory: CarInputValidatorsFactoryType {

    init() { }

    func createNameValidator() -> CarInputValidator {
        let message = NSLocalizedString("Name is required", comment: "Required name")
        let error = CarInputValidationError.invalidName(message)

        // Required length rule

        var rules = ValidationRuleSet<String>()
        let ruleRequired = ValidationRuleLength(min: 1, error: error)
        rules.add(rule: ruleRequired)

        return Result<String, ValidationErrors>.createValidator(using: rules)
    }

    func createBrandValidator() -> CarInputValidator {
        let message = NSLocalizedString("Brand is required", comment: "Required brand")
        let error = CarInputValidationError.invalidBrand(message)

        // Required length rule

        var rules = ValidationRuleSet<String>()
        let ruleRequired = ValidationRuleLength(min: 1, error: error)
        rules.add(rule: ruleRequired)

        return Result<String, ValidationErrors>.createValidator(using: rules)
    }

    func createModelValidator() -> CarInputValidator {
        let message = NSLocalizedString("Model is required", comment: "Required model")
        let error = CarInputValidationError.invalidBrand(message)

        // Required length rule

        var rules = ValidationRuleSet<String>()
        let ruleRequired = ValidationRuleLength(min: 1, error: error)
        rules.add(rule: ruleRequired)

        return Result<String, ValidationErrors>.createValidator(using: rules)
    }

    func createYearValidator() -> CarInputValidator {
        var rules = ValidationRuleSet<String>()

        // Digits rule

        let errorDigits = CarInputValidationError.invalidBrand(
            NSLocalizedString("Year should contain only digits", comment: "Required year digits only")
        )

        let ruleDigits = ValidationRuleCondition(error: errorDigits) { (value: String?) -> Bool in
            guard let text = value else { return false }
            guard text.characters.count > 0 else { return false }
            let nonDigits = CharacterSet.decimalDigits.inverted
            return text.rangeOfCharacter(from: nonDigits) == nil
        }

        rules.add(rule: ruleDigits)

        // Length rule

        let errorLength = CarInputValidationError.invalidBrand(
            NSLocalizedString("Year should be 4 characters long", comment: "Required year 4 characters long")
        )

        let ruleLength = ValidationRuleLength(min: 4, max: 4, error: errorLength)
        rules.add(rule: ruleLength)

        return Result<String, ValidationErrors>.createValidator(using: rules)
    }
}
