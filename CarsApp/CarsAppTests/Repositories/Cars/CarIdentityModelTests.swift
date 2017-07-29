//
//  CarIdentityModelTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarIdentityModelTests {

    func testModel() {
        let model = CarIdentityModel("1")

        expect(model.id).to(equal("1"))
    }

    func testEquatable() {
        let model = CarIdentityModel("1")

        expect(model).to(equal(model))

        let diff = CarIdentityModel("2")

        expect(model).toNot(equal(diff))
    }
}
