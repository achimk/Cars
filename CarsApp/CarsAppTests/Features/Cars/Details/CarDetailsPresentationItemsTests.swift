//
//  CarDetailsPresentationItemsTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarDetailsPresentationItemTests: XCTestCase {

    func testParameters() {
        let date = Date(timeIntervalSince1970: 0)
        let car = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        var item: CarDetailsItemPresentable = CarDetailsPresentationItem(car: car, param: .name)

        expect(item.parameter).to(equal("Name:"))

        item = CarDetailsPresentationItem(car: car, param: .brand)

        expect(item.parameter).to(equal("Brand:"))

        item = CarDetailsPresentationItem(car: car, param: .model)

        expect(item.parameter).to(equal("Model:"))

        item = CarDetailsPresentationItem(car: car, param: .year)

        expect(item.parameter).to(equal("Year:"))
    }

    func testValues() {
        let date = Date(timeIntervalSince1970: 0)
        let car = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        var item: CarDetailsItemPresentable = CarDetailsPresentationItem(car: car, param: .name)

        expect(item.value).to(equal("Project Code 980"))

        item = CarDetailsPresentationItem(car: car, param: .brand)

        expect(item.value).to(equal("Porsche"))

        item = CarDetailsPresentationItem(car: car, param: .model)

        expect(item.value).to(equal("Carrera GT"))

        item = CarDetailsPresentationItem(car: car, param: .year)
        
        expect(item.value).to(equal("1970"))
    }
}
