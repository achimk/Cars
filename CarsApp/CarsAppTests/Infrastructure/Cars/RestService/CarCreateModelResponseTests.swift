//
//  CarCreateModelResponseTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
import ObjectMapper
@testable import CarsApp

final class CarCreateModelResponseTests: XCTestCase {

    func testMapping() {

        let json: Dictionary<String, Any> = [
            "_id" : "123",
            "name" : "Name",
            "model" : "Model",
            "brand" : "Brand",
            "year" : "1234",
            "_created" : "CreatedTimestamp",
            "_changed" : "ChangedTimestamp",
            "_tags" : "tag1 tag2 tag3",
            "_version" : "1"
        ]

        let map = Map(mappingType: .fromJSON, JSON: json)

        var result = CarCreateModelResponse()
        result.mapping(map: map)

        expect(result.id).to(equal("123"))
        expect(result.name).to(equal("Name"))
        expect(result.model).to(equal("Model"))
        expect(result.brand).to(equal("Brand"))
        expect(result.year).to(equal("1234"))
        expect(result.createdTimestamp).to(equal("CreatedTimestamp"))
        expect(result.changedTimestamp).to(equal("ChangedTimestamp"))
        expect(result.tags).to(equal("tag1 tag2 tag3"))
        expect(result.version).to(equal("1"))
    }
}
