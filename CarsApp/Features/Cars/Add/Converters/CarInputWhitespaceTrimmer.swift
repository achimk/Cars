//
//  CarInputWhitespaceTrimmer.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

final class CarInputWhitespaceTrimmer: CarInputConverterFactoryType {

    static func create() -> CarInputConverter {
        return CarInputConverter { (value) -> String in
            guard let input = value else { return "" }
            return input.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
