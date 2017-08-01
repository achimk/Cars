//
//  CarCreateModelResponse.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import ObjectMapper

struct CarCreateModelResponse: Mappable {
    var id: String?
    var name: String?
    var model: String?
    var brand: String?
    var year: String?
    var createdTimestamp: String?
    var changedTimestamp: String?
    var tags: String?
    var version: String?

    init() { }

    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
        model <- map["model"]
        brand <- map["brand"]
        year <- map["year"]
        createdTimestamp <- map["_created"]
        changedTimestamp <- map["_changed"]
        tags <- map["_tags"]
        version <- map["_version"]
    }
}
