//
//  CarAddViewModelTests.swift
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

final class CarAddViewModelTests: QuickSpec {

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

    struct SuccessService: CarAddServiceType {
        init() { }
        func createCar(with model: CarCreateModel) -> Observable<Void> {
            return Observable.just()
        }
    }

    struct FailureService: CarAddServiceType {
        let error: CarsServiceError
        init(_ error: CarsServiceError = .cantConnect) {
            self.error = error
        }
        func createCar(with model: CarCreateModel) -> Observable<Void> {
            return Observable.error(error)
        }
    }

    override func spec() {
        let validator = notEmptyValidator
        let converter = CarInputConverter { val in
            return val ?? ""
        }

        let setupInput: ((CarAddViewModelType, CarInputType, String?) -> Void) = { (vm, type, val) in
            for input in vm.outputs.currentInputs {
                if input.outputs.inputType == type {
                    input.inputs.change(input: val)
                }
            }
        }

        describe("View Model Inputs") {

            let vm: CarAddViewModelType = CarAddViewModel(
                service: SuccessService(),
                validators: Validators(validator),
                converter: converter,
                specs: CarAddViewModelSpecs(
                    isFormEnabledByValidationResult: true
                )
            )

            context("Starts with default values") {

                it("Should always have 4 input items") {

                    expect(vm.outputs.currentInputs).to(haveCount(4))
                }
            }
        }

        describe("View Model Form Validation") {
            var vm: CarAddViewModelType!

            beforeEach {
                vm = CarAddViewModel(
                    service: SuccessService(),
                    validators: Validators(validator),
                    converter: converter,
                    specs: CarAddViewModelSpecs(
                        isFormEnabledByValidationResult: true
                    )
                )
            }


            context("Have invalid input") {

                it("Should be disabled") {

                    var isEnabled: Bool = false
                    let bag = DisposeBag()
                    vm.outputs.onFormEnabled.drive(onNext: { (enabled) in
                        isEnabled = enabled
                    }).addDisposableTo(bag)

                    expect(isEnabled).to(beFalse())

                    setupInput(vm, .name, "a")

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)

                    setupInput(vm, .brand, "b")

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)

                    setupInput(vm, .model, "c")

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)
                    
                    setupInput(vm, .year, nil)
                    
                    expect(isEnabled).toEventually(beFalse(), timeout: 1)
                }
            }

            context("Have valid input") {

                it("Should be enabled") {

                    var isEnabled: Bool = false
                    let bag = DisposeBag()
                    vm.outputs.onFormEnabled.drive(onNext: { (enabled) in
                        isEnabled = enabled
                    }).addDisposableTo(bag)

                    expect(isEnabled).to(beFalse())

                    setupInput(vm, .name, "a")

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)

                    setupInput(vm, .brand, "b")

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)

                    setupInput(vm, .model, "c")

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)

                    setupInput(vm, .year, "1234")

                    expect(isEnabled).toEventually(beTrue(), timeout: 1)
                }
            }
        }

        describe("View Model Save Functionality") {

            context("Have valid inputs and service") {

                let vm: CarAddViewModelType = CarAddViewModel(
                    service: SuccessService(),
                    validators: Validators(validator),
                    converter: converter,
                    specs: CarAddViewModelSpecs(
                        isFormEnabledByValidationResult: true
                    )
                )

                it("Should save values") {

                    var isEnabled: Bool = false
                    var loadings: Array<Bool> = []
                    var saveResult: CarSaveResult?
                    let bag = DisposeBag()

                    vm.outputs.onSaveResult.drive(onNext: { (result) in
                        saveResult = result
                    }).addDisposableTo(bag)

                    vm.outputs.onLoading.drive(onNext: { (flag) in
                        loadings.append(flag)
                    }).addDisposableTo(bag)

                    vm.outputs.onFormEnabled.drive(onNext: { (enabled) in
                        isEnabled = enabled
                    }).addDisposableTo(bag)


                    setupInput(vm, .name, "a")
                    setupInput(vm, .brand, "b")
                    setupInput(vm, .model, "c")
                    setupInput(vm, .year, "1234")

                    expect(isEnabled).toEventually(beTrue(), timeout: 1)
                    expect(saveResult).to(beNil())
                    expect(loadings).to(equal([false]))

                    vm.inputs.save()

                    expect(saveResult).toEventuallyNot(beNil(), timeout: 1)
                    expect(saveResult?.isSuccess).to(beTrue())
                    expect(loadings).to(equal([false, true, false]))
                }
            }

            context("Have valid inputs and invalid service") {

                let vm: CarAddViewModelType = CarAddViewModel(
                    service: FailureService(),
                    validators: Validators(validator),
                    converter: converter,
                    specs: CarAddViewModelSpecs(
                        isFormEnabledByValidationResult: true
                    )
                )

                it("Should fail to save values") {

                    var isEnabled: Bool = false
                    var loadings: Array<Bool> = []
                    var saveResult: CarSaveResult?
                    let bag = DisposeBag()

                    vm.outputs.onSaveResult.drive(onNext: { (result) in
                        saveResult = result
                    }).addDisposableTo(bag)

                    vm.outputs.onLoading.drive(onNext: { (flag) in
                        loadings.append(flag)
                    }).addDisposableTo(bag)

                    vm.outputs.onFormEnabled.drive(onNext: { (enabled) in
                        isEnabled = enabled
                    }).addDisposableTo(bag)


                    setupInput(vm, .name, "a")
                    setupInput(vm, .brand, "b")
                    setupInput(vm, .model, "c")
                    setupInput(vm, .year, "1234")

                    expect(isEnabled).toEventually(beTrue(), timeout: 1)
                    expect(saveResult).to(beNil())
                    expect(loadings).to(equal([false]))

                    vm.inputs.save()

                    expect(saveResult).toEventuallyNot(beNil(), timeout: 1)
                    expect(saveResult?.isSuccess).to(beFalse())
                    expect(loadings).to(equal([false, true, false]))
                }
            }

            context("Have invalid inputs and valid service") {

                let vm: CarAddViewModelType = CarAddViewModel(
                    service: SuccessService(),
                    validators: Validators(validator),
                    converter: converter,
                    specs: CarAddViewModelSpecs(
                        isFormEnabledByValidationResult: true
                    )
                )

                it("Should fail to save values") {

                    var isEnabled: Bool = false
                    var loadings: Array<Bool> = []
                    var saveResult: CarSaveResult?
                    let bag = DisposeBag()

                    vm.outputs.onSaveResult.drive(onNext: { (result) in
                        saveResult = result
                    }).addDisposableTo(bag)

                    vm.outputs.onLoading.drive(onNext: { (flag) in
                        loadings.append(flag)
                    }).addDisposableTo(bag)

                    vm.outputs.onFormEnabled.drive(onNext: { (enabled) in
                        isEnabled = enabled
                    }).addDisposableTo(bag)


                    setupInput(vm, .name, "a")
                    setupInput(vm, .brand, "b")
                    setupInput(vm, .model, "c")
                    setupInput(vm, .year, nil)

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)
                    expect(saveResult).to(beNil())
                    expect(loadings).to(equal([false]))

                    vm.inputs.save()

                    expect(saveResult).toEventually(beNil(), timeout: 1)
                    expect(loadings).to(equal([false]))
                }
            }

            context("Have invalid inputs and invalid service") {

                let vm: CarAddViewModelType = CarAddViewModel(
                    service: FailureService(),
                    validators: Validators(validator),
                    converter: converter,
                    specs: CarAddViewModelSpecs(
                        isFormEnabledByValidationResult: true
                    )
                )

                it("Should fail to save values") {

                    var isEnabled: Bool = false
                    var loadings: Array<Bool> = []
                    var saveResult: CarSaveResult?
                    let bag = DisposeBag()

                    vm.outputs.onSaveResult.drive(onNext: { (result) in
                        saveResult = result
                    }).addDisposableTo(bag)

                    vm.outputs.onLoading.drive(onNext: { (flag) in
                        loadings.append(flag)
                    }).addDisposableTo(bag)

                    vm.outputs.onFormEnabled.drive(onNext: { (enabled) in
                        isEnabled = enabled
                    }).addDisposableTo(bag)


                    setupInput(vm, .name, "a")
                    setupInput(vm, .brand, "b")
                    setupInput(vm, .model, "c")
                    setupInput(vm, .year, nil)

                    expect(isEnabled).toEventually(beFalse(), timeout: 1)
                    expect(saveResult).to(beNil())
                    expect(loadings).to(equal([false]))

                    vm.inputs.save()
                    
                    expect(saveResult).toEventually(beNil(), timeout: 1)
                    expect(loadings).to(equal([false]))
                }
            }
        }
    }
}
