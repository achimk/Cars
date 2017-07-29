//
//  LocationType.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol LocationType {
    var scheme: String { get }
    var path: String { get }
    var arguments: Dictionary<String, String> { get }
    var payload: Optional<Any> { get }
}
