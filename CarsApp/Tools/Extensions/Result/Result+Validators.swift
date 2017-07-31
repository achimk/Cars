//
//  Result+Validators.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result

extension Result {

    static func createValidator(
        using validator: @escaping Validator<T>,
        error: Error) -> ResultValidator<T, Error> {

        return { value in
            guard let value = value else { return Result(error: error) }
            return validator(value) ? Result(value: value) : Result(error: error)
        }
    }
}
