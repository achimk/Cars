//
//  CarsModelEntityMapperTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarsModelEntityMapperTests: XCTestCase {

    func testMapFromModelToEntity() {
        let input = CarModel(
            id: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            year: 1970
        )

        let output = CarsModelEntityMapper.from(input)

        expect(output.identifier).to(equal(input.id))
        expect(output.name).to(equal(input.name))
        expect(output.model).to(equal(input.model))
        expect(output.brand).to(equal(input.brand))
        expect(output.manufactureDate).to(equal(Date(timeIntervalSince1970: 0)))
    }

    func testMapFromEntityToModel() {
        let date = Date(timeIntervalSince1970: 0)
        let input: CarType = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        let output = CarsModelEntityMapper.from(input)

        expect(output.id).to(equal(input.identifier))
        expect(output.name).to(equal(input.name))
        expect(output.model).to(equal(input.model))
        expect(output.brand).to(equal(input.brand))
        expect(output.year).to(equal(1970))
    }
}
