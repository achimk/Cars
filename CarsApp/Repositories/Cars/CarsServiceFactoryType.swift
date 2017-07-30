//
//  CarsServiceFactoryType.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarsServiceFactoryType {
    static func create() -> CarsServiceType
}
