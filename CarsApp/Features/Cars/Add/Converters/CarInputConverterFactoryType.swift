//
//  CarInputConverterFactoryType.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

typealias CarInputConverter = Reader<String?, String>

protocol CarInputConverterFactoryType {
    static func create() -> CarInputConverter
}
