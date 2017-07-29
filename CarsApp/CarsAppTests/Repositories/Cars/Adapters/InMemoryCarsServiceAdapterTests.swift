//
//  InMemoryCarsServiceAdapterTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import CarsApp

final class InMemoryCarsServiceAdapterTests: QuickSpec {

    override func spec() {

        describe("In Memory Cars Service") {
            var service: CarsServiceType!

            context("Start with empty list") {

                beforeEach {
                    service = InMemoryCarsServiceAdapter()
                }

                it("Should return empty list") {

                    do {
                        let results = try service
                            .requestCarsList()
                            .toBlocking()
                            .single()

                        expect(results).to(haveCount(0))

                    } catch {
                        fail("Should never happen")
                    }
                }

                it("Can add car to the list") {

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

                        expect(results).to(haveCount(1))

                    } catch {
                        fail("Should never happen")
                    }
                }
            }

            context("Start with populated list", closure: {

                beforeEach {
                    service = InMemoryCarsServiceAdapter(self.createModels())
                }

                it("Should return not empty list") {

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

                it("Can add car to the list") {

                    do {
                        let model = CarCreateModel(
                            name: "My Mercedes",
                            model: "GT R",
                            brand: "Mercedes-AMG",
                            year: 2016
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

                it("Should succeed when found car on the list") {

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

                it("Should fail when does not found car on the list") {

                    do {
                        let identity = CarIdentityModel("4")

                        let _ = try service
                            .requestCarDetails(using: identity)
                            .toBlocking()
                            .single()

                        fail("Should never happen")
                    } catch let error as CarsServiceError {

                        expect(error).to(equal(CarsServiceError.notFound))

                    } catch {
                        fail("Should never happen")
                    }
                }
            })
        }
    }

    private func createModels() -> Array<CarModel> {
        return [
            CarModel(id: "1", name: "My Porsche", model: "Carrera GT", brand: "Porsche", year: 2004),
            CarModel(id: "2", name: "My Ferrari", model: "458 Italia", brand: "Ferrari", year: 2010),
            CarModel(id: "3", name: "My McLaren", model: "P1", brand: "McLaren", year: 2013)
        ]
    }
}
