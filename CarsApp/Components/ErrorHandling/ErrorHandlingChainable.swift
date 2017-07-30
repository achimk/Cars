//
//  ErrorHandlingChainable.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol ErrorHandlingChainable: class, ErrorHandling {
    var next: ErrorHandlingChainable? { get set }
}

extension ErrorHandlingChainable {
    var next: ErrorHandlingChainable? {
        set { }
        get { return nil }
    }

    func can(handle error: Error) -> Bool {
        return next?.can(handle: error) ?? false
    }

    final func last() -> ErrorHandlingChainable {
        return next?.last() ?? self
    }
}
