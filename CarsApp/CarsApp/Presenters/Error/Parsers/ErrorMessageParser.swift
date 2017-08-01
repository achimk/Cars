//
//  ErrorMessageParser.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct ErrorMessageParser: ErrorMessageParserType {

    init() { }

    func parse(_ error: Error) -> String {

        switch error {
        case let error as CarsServiceError:
            return carsServiceError(error)

        case let error as CarSaveError:
            return carSaveError(error)

        case let error as ValidationErrors:
            return formValidationError(error)

        default: return unknownError()
        }
    }

    private func carSaveError(_ error: CarSaveError) -> String {
        switch error {
        case .invalidForm(let formError): return formValidationError(formError)
        case .serviceError(let serviceError): return carsServiceError(serviceError)
        case .unknown: return unknownError()
        }
    }

    private func formValidationError(_ error: ValidationErrors) -> String {
        guard let first = error.errors.first else {
            return unknownFormError()
        }
        return first.localizedDescription
    }

    private func carsServiceError(_ error: CarsServiceError) -> String {
        return NSLocalizedString("Service connection error", comment: "Cars service error occurs")
    }

    private func unknownFormError() -> String {
        return NSLocalizedString("form error", comment: "Unknown form error occurs")
    }

    private func unknownError() -> String {
        return NSLocalizedString("Unknown error", comment: "Generic error occurs")
    }
}
