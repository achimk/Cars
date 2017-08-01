//
//  NetworkingTypes.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

typealias Parameters = Dictionary<String, Any>
typealias HTTPHeaders = Dictionary<String, String>

enum HTTPMethod : String {
    case get
    case post
}
