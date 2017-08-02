//
//  AppTypes.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

enum Environment: String {
    case testing
    case staging
    case production
}

// MARK: App Namespace

struct App {
    struct Current { }
}

// MARK: Current

extension App.Current {
    static let environment: Environment = .testing
}
