//
//  AppTypes.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

enum Environment: String {
    case develop
    case production
}

struct App {
    static let environment: Environment = .production
}
