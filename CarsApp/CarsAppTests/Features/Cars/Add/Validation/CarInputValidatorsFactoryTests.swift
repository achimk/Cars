//
//  CarInputValidatorsFactoryTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarInputValidatorsFactoryTests: XCTestCase {

    func testNameValidator() {
        let factory = CarInputValidatorsFactory()
        let validator = factory.createNameValidator()

        expect(validator("").isSuccess).to(beFalse())

        expect(validator(" ").isSuccess).to(beTrue())
        expect(validator("a").isSuccess).to(beTrue())
    }

    func testBrandValidator() {
        let factory = CarInputValidatorsFactory()
        let validator = factory.createBrandValidator()

        expect(validator("").isSuccess).to(beFalse())

        expect(validator(" ").isSuccess).to(beTrue())
        expect(validator("a").isSuccess).to(beTrue())
    }

    func testModelValidator() {
        let factory = CarInputValidatorsFactory()
        let validator = factory.createModelValidator()

        expect(validator("").isSuccess).to(beFalse())

        expect(validator(" ").isSuccess).to(beTrue())
        expect(validator("a").isSuccess).to(beTrue())
    }

    func testYearValidator() {
        let factory = CarInputValidatorsFactory()
        let validator = factory.createYearValidator()

        expect(validator("").isSuccess).to(beFalse())
        expect(validator(" ").isSuccess).to(beFalse())
        expect(validator("a").isSuccess).to(beFalse())
        expect(validator("123").isSuccess).to(beFalse())
        expect(validator("123a").isSuccess).to(beFalse())
        expect(validator("1233 ").isSuccess).to(beFalse())
        expect(validator("a1233").isSuccess).to(beFalse())

        expect(validator("1233").isSuccess).to(beTrue())

    }
}
