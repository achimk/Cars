//
//  CarType.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarType {
    var identifier: String { get }
    var name: String { get }
    var model: String { get }
    var brand: String { get }
    var manufactureDate: Date { get }
}

protocol CarConvertible {
    func asCar() -> CarType
}

extension CarConvertible where Self: CarType {
    final func asCar() -> CarType {
        return self
    }
}
