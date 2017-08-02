//
//  CarModelResponseTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
import ObjectMapper
@testable import CarsApp

final class CarModelResponseTests: XCTestCase {

    func testModelMapping() {

        let json: Dictionary<String, Any> = [
            "_id" : "123",
            "name" : "Name",
            "model" : "Model",
            "brand" : "Brand",
            "year" : "1234"
        ]

        let map = Map(mappingType: .fromJSON, JSON: json)

        var result = CarModelResponse()
        result.mapping(map: map)

        expect(result.id).to(equal("123"))
        expect(result.name).to(equal("Name"))
        expect(result.model).to(equal("Model"))
        expect(result.brand).to(equal("Brand"))
        expect(result.year).to(equal("1234"))
    }
}
