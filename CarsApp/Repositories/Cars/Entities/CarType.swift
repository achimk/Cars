//
//  CarType.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarConvertible {
    func asCar() -> CarType
}

protocol CarEquatable {
    func isEqual(to other: CarType) -> Bool
}

protocol CarType: CarEquatable, CarConvertible {
    var identifier: String { get }
    var name: String? { get }
    var model: String? { get }
    var brand: String? { get }
    var manufactureDate: Date? { get }
}

extension CarType {
    final func asCreateModel() -> CarCreateModel {
        let year = CarsModelEntityMapper.year(from: manufactureDate)
        return CarCreateModel(
            name: name,
            model: model,
            brand: brand,
            year: year
        )
    }

    final func asIdentityModel() -> CarIdentityModel {
        return CarIdentityModel(identifier)
    }

    final func asCar() -> CarType {
        return self
    }

    final func isEqual(to other: CarType) -> Bool {
        return identifier == other.identifier
            && name == other.name
            && model == other.model
            && brand == other.brand
            && manufactureDate == other.manufactureDate
    }
}

//extension CarConvertible where Self: CarType {
//    final func asCar() -> CarType {
//        return self
//    }
//}

////extension Equatable where Self: CarType { }
//func ==(lhs: CarType, rhs: CarType) -> Bool {
//    return lhs.identifier == rhs.identifier
//        && lhs.name == rhs.name
//        && lhs.model == rhs.model
//        && lhs.brand == rhs.brand
//        && lhs.manufactureDate == rhs.manufactureDate
//}
