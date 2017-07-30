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

        if let _ = error as? CarsServiceError {
            return NSLocalizedString("Service connection error", comment: "Cars service error occurs")
        } else {
            return NSLocalizedString("Unknown error", comment: "Generic error occurs")
        }
    }
}
