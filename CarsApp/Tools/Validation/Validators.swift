//
//  Validators.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result

typealias Validator<T> = ((T?) -> Bool)
typealias ResultValidator<T, E: Error> = ((T?) -> Result<T, E>)

struct Validation {

    // MARK: Generic Validators

    static func alwaysTrue<T>() -> Validator<T> {
        return { _ in return true }
    }

    static func alwaysFalse<T>() -> Validator<T> {
        return { _ in return false }
    }

    // MARK: String Validators

    static func isNotEmpty() -> Validator<String> {
        return { value in
            guard let value = value else { return false }
            return value.characters.count > 0
        }
    }

    static func isEmpty() -> Validator<String> {
        return { value in
            guard let value = value else { return false }
            return value.characters.count == 0
        }
    }

    static func isPatternValid(_ pattern: String?, onInvalidPattern: @escaping Validator<String>) -> Validator<String> {

        guard let pattern = pattern else {
            return onInvalidPattern
        }

        guard let regex = try? NSRegularExpression(
            pattern: pattern,
            options: []) else {
                return onInvalidPattern
        }

        return isRegexValid(regex)
    }

    static func isRegexValid(_ regex: NSRegularExpression) -> Validator<String> {
        return { value in
            guard let value = value else { return false }

            let range = NSRange(location: 0, length: value.characters.count)
            let result = regex.firstMatch(in: value, options: [], range: range)
            return result != nil
        }
    }
}
