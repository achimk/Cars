//
//  CarEntityTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarEntityTests: XCTestCase {

    func testModel() {
        let date = Date()
        let car: CarType = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        expect(car.identifier).to(equal("1"))
        expect(car.name).to(equal("Project Code 980"))
        expect(car.model).to(equal("Carrera GT"))
        expect(car.brand).to(equal("Porsche"))
        expect(car.manufactureDate).to(equal(date))
    }

    func testEquatable() {
        let date = Date(timeIntervalSince1970: 0)
        let car: CarType = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        expect(car.isEqual(to: car)).to(beTrue())

        let diffId: CarType = Car(
            identifier: "2",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        expect(car.isEqual(to: diffId)).to(beFalse())

        let diffName: CarType = Car(
            identifier: "1",
            name: "Project Code",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        expect(car.isEqual(to: diffName)).to(beFalse())

        let diffModel: CarType = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera",
            brand: "Porsche",
            manufactureDate: date
        )

        expect(car.isEqual(to: diffModel)).to(beFalse())

        let diffBrand: CarType = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Fiat",
            manufactureDate: date
        )

        expect(car.isEqual(to: diffBrand)).to(beFalse())

        let diffManufactureDate: CarType = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: Date(timeIntervalSince1970: 1)
        )

        expect(car.isEqual(to: diffManufactureDate)).to(beFalse())
    }

    func testConversionToCreateModel() {
        let date = Date(timeIntervalSince1970: 0)
        let car = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        let create = CarCreateModel(
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            year: "1970"
        )

        expect(car.asCreateModel()).to(equal(create))
    }

    func testConversionToIdentityModel() {
        let date = Date(timeIntervalSince1970: 0)
        let car = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        let identity = CarIdentityModel("1")

        expect(car.asIdentityModel()).to(equal(identity))
    }

    func testConversionToCarType() {
        let date = Date()
        let car = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        let other = car.asCar()

        expect(car.isEqual(to: other)).to(beTrue())
    }
}
