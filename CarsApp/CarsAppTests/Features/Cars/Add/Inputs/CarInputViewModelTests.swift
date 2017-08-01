//
//  CarInputViewModelTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxBlocking
import Result
@testable import CarsApp

final class CarInputViewModelTests: QuickSpec {

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

    final class StepBuilderSpy: CarStepCreateConfigurable {
        var name: String?
        var brand: String?
        var model: String?
        var year: String?

        init() { }

        func set(name: String?) { self.name = name }
        func set(brand: String?) { self.brand = brand }
        func set(model: String?) { self.model = model }
        func set(year: String?) { self.year = year }
    }

    override func spec() {

        let validator = self.notEmptyValidator

        var shouldConvertToDefaultValue = false
        let converter = CarInputConverter { val in
            if shouldConvertToDefaultValue {
                return "DefaultValue"
            }
            return val ?? ""
        }

        describe("Input View Model") {
            var vm: CarInputViewModelType!

            beforeEach {
                shouldConvertToDefaultValue = false
                vm = CarInputViewModel(
                    inputType: .name,
                    converter: converter,
                    validator: validator
                )
            }

            context("Default initializer") {

                it("Should have default current placeholder, text and input type") {

                    expect(vm.outputs.inputType).to(equal(CarInputType.name))
                    expect(vm.outputs.currentPlaceholder).toNot(beNil())
                    expect(vm.outputs.currentText).to(beNil())
                }
            }

            context("Validate result") {

                it("Should succeed for not empty input") {

                    do {
                        vm.inputs.change(input: "name")

                        let result = try vm.outputs
                            .onTextResult
                            .toBlocking()
                            .first()

                        expect(result?.isSuccess).to(beTrue())
                        expect(result?.value).to(equal("name"))

                    } catch {
                        fail("Should never happen")
                    }
                }

                it("Should fail for empty input") {

                    do {
                        vm.inputs.change(input: "")

                        let result = try vm.outputs
                            .onTextResult
                            .toBlocking()
                            .first()

                        expect(result?.isSuccess).to(beFalse())

                    } catch {
                        fail("Should never happen")
                    }
                }
            }

            context("Converter") {

                it("Should return converted result") {

                    shouldConvertToDefaultValue = true

                    do {
                        vm.inputs.change(input: "")

                        let result = try vm.outputs
                            .onTextResult
                            .toBlocking()
                            .first()

                        expect(result?.isSuccess).to(beTrue())
                        expect(result?.value).to(equal("DefaultValue"))

                    } catch {
                        fail("Should never happen")
                    }
                }
            }
        }

        describe("Input Name") {
            let vm: CarInputViewModelType = CarInputViewModel(
                inputType: .name,
                converter: converter,
                validator: validator
            )

            context("Accepts step builder") {

                it("Should receive valid name") {

                    let spy = StepBuilderSpy()

                    vm.inputs.change(input: "ada123")
                    vm.inputs.accept(spy)

                    expect(spy.name).to(equal("ada123"))
                }
            }
        }

        describe("Input Brand") {
            let vm: CarInputViewModelType = CarInputViewModel(
                inputType: .brand,
                converter: converter,
                validator: validator
            )

            context("Accepts step builder") {

                it("Should receive valid brand") {

                    let spy = StepBuilderSpy()

                    vm.inputs.change(input: "ada123")
                    vm.inputs.accept(spy)

                    expect(spy.brand).to(equal("ada123"))
                }
            }
        }

        describe("Input Model") {
            let vm: CarInputViewModelType = CarInputViewModel(
                inputType: .model,
                converter: converter,
                validator: validator
            )

            context("Accepts step builder") {

                it("Should receive valid model") {

                    let spy = StepBuilderSpy()

                    vm.inputs.change(input: "ada123")
                    vm.inputs.accept(spy)

                    expect(spy.model).to(equal("ada123"))
                }
            }
        }

        describe("Input Year") {
            let vm: CarInputViewModelType = CarInputViewModel(
                inputType: .year,
                converter: converter,
                validator: validator
            )

            context("Accepts step builder") {

                it("Should receive valid year") {

                    let spy = StepBuilderSpy()

                    vm.inputs.change(input: "ada123")
                    vm.inputs.accept(spy)

                    expect(spy.year).to(equal("ada123"))
                }
            }
        }
    }

}
