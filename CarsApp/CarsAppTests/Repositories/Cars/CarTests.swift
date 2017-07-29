//
//  CarTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarTests: XCTestCase {

    func testCreate() {
        let date = Date()
        let car: CarType = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carriera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        expect(car.identifier).to(equal("1"))
        expect(car.name).to(equal("Project Code 980"))
        expect(car.model).to(equal("Carriera GT"))
        expect(car.brand).to(equal("Porsche"))
        expect(car.manufactureDate).to(equal(date))
    }
}
