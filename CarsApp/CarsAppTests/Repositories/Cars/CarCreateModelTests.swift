//
//  CarCreateModelTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarCreateModelTests: XCTestCase {

    func testModel() {

        let car = CarCreateModel(
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            year: "2004"
        )

        expect(car.name).to(equal("Project Code 980"))
        expect(car.model).to(equal("Carrera GT"))
        expect(car.brand).to(equal("Porsche"))
        expect(car.year).to(equal("2004"))
    }

    func testEquatable() {
        let car = CarCreateModel(
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            year: "2004"
        )

        expect(car).to(equal(car))

        let diffName = CarCreateModel(
            name: "Project Code 98",
            model: "Carrera GT",
            brand: "Porsche",
            year: "2004"
        )

        expect(car).toNot(equal(diffName))

        let diffModel = CarCreateModel(
            name: "Project Code 980",
            model: "Carrera",
            brand: "Porsche",
            year: "2004"
        )

        expect(car).toNot(equal(diffModel))

        let diffBrand = CarCreateModel(
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Fiat",
            year: "2004"
        )

        expect(car).toNot(equal(diffBrand))

        let diffYear = CarCreateModel(
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            year: "2001"
        )

        expect(car).toNot(equal(diffYear))
    }
}
