//
//  CarCreateBuilderType.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarStepConfigurable {
    func set(name: String?)
    func set(brand: String?)
    func set(model: String?)
    func set(year: String?)
}

protocol CarConfiguratorAcceptable {
    func accept(_ configurator: CarStepConfigurable)
}

protocol CarCreateBuilderType {
    func build() throws -> CarCreateModel
}
