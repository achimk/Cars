//
//  DelayCarsServiceTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import CarsApp

final class DelayCarsServiceTests: QuickSpec {

    override func spec() {

        describe("Delay Cars Service") {

            context("Initialized with mock service") {
                var service: CarsServiceType!

                beforeEach {
                    let mock = MocksCarsServiceFactory.create()
                    service = DelayCarsService(service: mock)
                }

                it("Should delay after list subscription") {

                    do {
                        let results = try service
                            .requestCarsList()
                            .toBlocking()
                            .single()

                        expect(results).to(haveCount(3))

                    } catch {
                        fail("Should never happen")
                    }
                }

                it("Should delay after details subscription") {

                    do {
                        let identity = CarIdentityModel("1")

                        let car = try service
                            .requestCarDetails(using: identity)
                            .toBlocking()
                            .single()

                        expect(car).toNot(beNil())

                    } catch {
                        fail("Should never happen")
                    }
                }

                it("Should delay after add subscription") {

                    do {
                        let model = CarCreateModel(
                            name: "Project Code 980",
                            model: "Carrera GT",
                            brand: "Porsche",
                            year: 2004
                        )

                        let _ = try service
                            .createCar(with: model)
                            .toBlocking()
                            .single()

                        let results = try service
                            .requestCarsList()
                            .toBlocking()
                            .single()

                        expect(results).to(haveCount(4))

                    } catch {
                        fail("Should never happen")
                    }
                }
            }
        }
    }
}
