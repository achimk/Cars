//
//  CarsListPresentationItemTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarsListPresentationItemTests: XCTestCase {

    func testPresentTitle() {
        let date = Date()
        var car = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        var item = CarsListPresentationItem(car)

        expect(item.title).to(equal("Project Code 980"))

        car.name = nil
        item = CarsListPresentationItem(car)

        expect(item.title).to(equal(""))
    }

    func testPresentSubtitle() {
        let date = Date(timeIntervalSince1970: 0)
        var car = Car(
            identifier: "1",
            name: "Project Code 980",
            model: "Carrera GT",
            brand: "Porsche",
            manufactureDate: date
        )

        var item = CarsListPresentationItem(car)

        expect(item.subtitle).to(equal("Porsche Carrera GT (1970)"))

        car.brand = nil
        item = CarsListPresentationItem(car)

        expect(item.subtitle).to(equal("Carrera GT (1970)"))

        car.model = nil
        car.brand = "Porsche"
        item = CarsListPresentationItem(car)

        expect(item.subtitle).to(equal("Porsche (1970)"))

        car.manufactureDate = nil
        car.model = "Carrera GT"
        item = CarsListPresentationItem(car)

        expect(item.subtitle).to(equal("Porsche Carrera GT"))

        car.brand = nil
        car.model = nil
        car.manufactureDate = nil
        item = CarsListPresentationItem(car)

        expect(item.subtitle).to(equal(""))
    }
}

