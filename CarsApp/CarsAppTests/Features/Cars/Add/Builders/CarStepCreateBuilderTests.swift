//
//  CarStepCreateBuilderTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
import Result
@testable import CarsApp

final class CarStepCreateBuilderTests: XCTestCase {

    let notEmptyValidator: CarInputValidator = {
        return { val in
            if val.characters.count > 0 {
                return Result.success(val)
            } else {
                let err = NSError(domain: "testError", code: 0, userInfo: nil)
                let errors = ValidationErrors([err])
                return Result.failure(errors)
            }
        }
    }()

    struct Validators: CarInputValidatorsFactoryType {
        let validator: CarInputValidator
        init(_ validator: @escaping CarInputValidator) {
            self.validator = validator
        }

        func createNameValidator() -> CarInputValidator {
            return validator
        }

        func createBrandValidator() -> CarInputValidator {
            return validator
        }

        func createModelValidator() -> CarInputValidator {
            return validator
        }

        func createYearValidator() -> CarInputValidator {
            return validator
        }
    }

    func testStepBuilderSuccess() {
        let builder = createBuilder(validator: notEmptyValidator)

        builder.set(name: "name")
        builder.set(brand: "brand")
        builder.set(model: "model")
        builder.set(year: "1234")

        do {
            let result = try builder.build()

            expect(result.name).to(equal("name"))
            expect(result.brand).to(equal("brand"))
            expect(result.model).to(equal("model"))
            expect(result.year).to(equal("1234"))

        } catch {
            fail("Should never happen")
        }
    }

    func testStepBuilderNameFailure() {
        let builder = createBuilder(validator: notEmptyValidator)

        builder.set(name: nil)
        builder.set(brand: "brand")
        builder.set(model: "model")
        builder.set(year: "1234")

        do {
            let _ = try builder.build()
            fail("Should never happen")
        } catch {
            expect(error).toNot(beNil())
        }
    }

    func testStepBuilderBrandFailure() {
        let builder = createBuilder(validator: notEmptyValidator)

        builder.set(name: "name")
        builder.set(brand: nil)
        builder.set(model: "model")
        builder.set(year: "1234")

        do {
            let _ = try builder.build()
            fail("Should never happen")
        } catch {
            expect(error).toNot(beNil())
        }
    }

    func testStepBuilderModelFailure() {
        let builder = createBuilder(validator: notEmptyValidator)

        builder.set(name: "name")
        builder.set(brand: "brand")
        builder.set(model: nil)
        builder.set(year: "1234")

        do {
            let _ = try builder.build()
            fail("Should never happen")
        } catch {
            expect(error).toNot(beNil())
        }
    }

    func testStepBuilderYearFailure() {
        let builder = createBuilder(validator: notEmptyValidator)

        builder.set(name: "name")
        builder.set(brand: "brand")
        builder.set(model: "model")
        builder.set(year: nil)

        do {
            let _ = try builder.build()
            fail("Should never happen")
        } catch {
            expect(error).toNot(beNil())
        }
    }

    func testStepBuilderWithPrepare() {
        let builder = createBuilder(validator: notEmptyValidator)

        builder.set(name: "name")
        builder.set(brand: "brand")
        builder.set(model: "model")
        builder.set(year: "1234")

        do {
            let result = try builder.build()

            expect(result.name).to(equal("name"))
            expect(result.brand).to(equal("brand"))
            expect(result.model).to(equal("model"))
            expect(result.year).to(equal("1234"))

        } catch {
            fail("Should never happen")
        }

        do {
            builder.prepareForUse()

            let _ = try builder.build()
            
            fail("Should never happen")
        } catch {
            expect(error).toNot(beNil())
        }
    }

    private func createBuilder(validator: @escaping CarInputValidator) -> CarStepCreateBuilderType {
        let converter = CarInputConverter { val in
            return val ?? ""
        }

        return CarStepCreateBuilder(
            validators: Validators(validator),
            converter: converter
        )
    }
}

