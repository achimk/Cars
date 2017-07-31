//
//  Result+Validators.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result
import Validator

struct ValidationErrors: Error {
    let errors: Array<Error>

    init(_ errors: Array<Error>) {
        self.errors = errors
    }
}

typealias ResultValidation<T> = ((T) -> Result<T, ValidationErrors>)

extension Result where T: Validatable {

    static func createValidator(using rules: ValidationRuleSet<T>) -> ResultValidation<T> {
        return { value in
            switch value.validate(rules: rules) {
            case .valid:
                return Result<T, ValidationErrors>(value: value)
            case .invalid(let errors):
                return Result<T, ValidationErrors>(error: ValidationErrors(errors))
            }
        }
    }
}
