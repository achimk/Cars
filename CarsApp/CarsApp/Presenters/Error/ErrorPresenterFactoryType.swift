//
//  ErrorPresenterFactoryType.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorPresenterFactoryType {
    static func create(using contextController: UIViewController?) -> ErrorPresenterType
}

extension ErrorPresenterFactoryType {
    static func create() -> ErrorPresenterType {
        return create(using: nil)
    }
}
