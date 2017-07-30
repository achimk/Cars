//
//  ErrorPresenterType.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol ErrorPresentable {
    func present(with error: Error)
}

protocol ErrorDismissible {
    func dismiss()
}

protocol ErrorPresenterType: ErrorPresentable, ErrorDismissible, ErrorHandlingChainable { }

extension ErrorPresenterType {
    func can(handle error: Error) -> Bool {
        return next?.can(handle: error) ?? false
    }
}
