//
//  LocationTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class LocationTests: XCTestCase {

    func testLocationCreate() {
        let location: LocationType = Location(
            scheme: "app",
            path: "test",
            arguments: ["a": "1", "b": "2"],
            payload: [1, 2, 3]
        )

        expect(location.scheme).to(equal("app"))
        expect(location.path).to(equal("test"))
        expect(location.arguments).to(equal(["a": "1", "b": "2"]))
        expect(location.payload as? Array<Int>).to(equal([1, 2, 3]))
    }
}
