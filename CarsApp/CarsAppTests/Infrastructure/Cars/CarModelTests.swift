//
//  CarModelTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarModelTests: XCTestCase {

    func testModel() {
        let model = CarModel(
            id: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            year: 2004
        )

        expect(model.id).to(equal("1"))
        expect(model.name).to(equal("Project Code 980"))
        expect(model.model).to(equal("Carrera GT"))
        expect(model.brand).to(equal("Porsche"))
        expect(model.year).to(equal(2004))
    }
}
