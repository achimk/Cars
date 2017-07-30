//
//  ErrorCarsServiceTests.swift
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

final class ErrorCarsServiceTests: QuickSpec {

    override func spec() {

        describe("Error Cars Service") {

            context("Initialized with cant connect parameter") {
                var service: CarsServiceType!

                beforeEach {
                    service = ErrorCarsService(error: .cantConnect)
                }

                it("Should fail after list subscription") {

                    do {
                        let _ = try service
                            .requestCarsList()
                            .toBlocking()
                            .single()

                        fail("Should never happen")

                    } catch let error as CarsServiceError {

                        expect(error).to(equal(CarsServiceError.cantConnect))

                    } catch {
                        fail("Should never happen")
                    }
                }

                it("Should fail after details subscription") {

                    do {
                        let identity = CarIdentityModel("1")

                        let _ = try service
                            .requestCarDetails(using: identity)
                            .toBlocking()
                            .single()

                        fail("Should never happen")

                    } catch let error as CarsServiceError {

                        expect(error).to(equal(CarsServiceError.cantConnect))

                    } catch {
                        fail("Should never happen")
                    }
                }

                it("Should fail after add subscription") {

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

                        fail("Should never happen")

                    } catch let error as CarsServiceError {

                        expect(error).to(equal(CarsServiceError.cantConnect))

                    } catch {
                        fail("Should never happen")
                    }
                }
            }
        }
    }
}
