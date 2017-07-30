//
//  ErrorHandler.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

final class ErrorHandler: ErrorHandlingChainable {
    typealias Handler = ((Error) -> Bool)
    private let handler: Handler
    var next: ErrorHandlingChainable?

    static func nopHandler() -> ErrorHandler {
        return ErrorHandler { _ in
            return false
        }
    }

    init(_ handler: @escaping Handler) {
        self.handler = handler
    }

    func can(handle error: Error) -> Bool {
        return handler(error) || (next?.can(handle: error) ?? false)
    }
}
