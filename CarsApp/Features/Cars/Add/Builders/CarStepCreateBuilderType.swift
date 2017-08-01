//
//  CarStepCreateBuilderType.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarStepCreateConfigurable {
    func set(name: String?)
    func set(brand: String?)
    func set(model: String?)
    func set(year: String?)
}

protocol CarStepCreatePreparable: class {
    func prepareForUse()
}

protocol CarStepCreateAcceptable {
    func accept(_ stepCreate: CarStepCreateConfigurable)
}

protocol CarStepCreateBuilderType: CarStepCreatePreparable, CarStepCreateConfigurable {
    func build() throws -> CarCreateModel
}
