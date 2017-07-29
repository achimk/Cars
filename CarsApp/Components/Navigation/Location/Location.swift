//
//  Location.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct Location: LocationType {
    let scheme: String
    let path: String
    let arguments: Dictionary<String, String>
    let payload: Optional<Any>

    init(scheme: String,
         path: String,
         arguments: Dictionary<String, String> = [:],
         payload: Optional<Any> = nil) {

        self.scheme = scheme
        self.path = path
        self.arguments = arguments
        self.payload = payload
    }
}
