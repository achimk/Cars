//
//  CarModelResponse.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import ObjectMapper

struct CarModelResponse: Mappable {
    var id: String?
    var name: String?
    var model: String?
    var brand: String?
    var year: String?

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
        model <- map["model"]
        brand <- map["brand"]
        year <- map["year"]
    }
}
