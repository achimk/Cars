//
//  CarDetailsViewModelTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxBlocking
import Result
@testable import CarsApp

final class CarDetailsViewModelTests: QuickSpec {

    override func spec() {

        describe("Car Details View Model") {

            context("Initialized with error service") {

                let service: CarsServiceType = ErrorCarsService(error: .cantConnect)
                let identity = CarIdentityModel("1")
                let vm: CarDetailsViewModelType = CarDetailsViewModel(identity: identity, service: service)
                let bag = DisposeBag()

                it("Should present error") {

                    var loadingStates: Array<Bool> = []
                    var output: CarDetailsResult?

                    vm.outputs.onPresentResult.drive(onNext: { (result) in
                        output = result
                    }).addDisposableTo(bag)

                    vm.outputs.onLoading.drive(onNext: { (isLoading) in
                        loadingStates.append(isLoading)
                    }).addDisposableTo(bag)


                    expect(loadingStates).to(haveCount(1))
                    expect(loadingStates).to(equal([false]))
                    expect(output).to(beNil())

                    vm.inputs.fetch()

                    expect(output).toEventuallyNot(beNil(), timeout: 1)
                    expect(output?.error).to(equal(CarsServiceError.cantConnect))
                    expect(loadingStates).to(haveCount(3))
                    expect(loadingStates).to(equal([false, true, false]))
                }
            }

            context("Initialized with mock service") {

                let service: CarsServiceType = MocksCarsServiceFactory.create()
                let identity = CarIdentityModel("1")
                let vm: CarDetailsViewModelType = CarDetailsViewModel(identity: identity, service: service)
                let bag = DisposeBag()

                it("Should present car parameters") {

                    var loadingStates: Array<Bool> = []
                    var output: CarDetailsResult?

                    vm.outputs.onPresentResult.drive(onNext: { (result) in
                        output = result
                    }).addDisposableTo(bag)

                    vm.outputs.onLoading.drive(onNext: { (isLoading) in
                        loadingStates.append(isLoading)
                    }).addDisposableTo(bag)


                    expect(loadingStates).to(haveCount(1))
                    expect(loadingStates).to(equal([false]))
                    expect(output).to(beNil())

                    vm.inputs.fetch()
                    
                    expect(output).toEventuallyNot(beNil(), timeout: 1)
                    expect(output?.value).to(haveCount(4))
                    expect(loadingStates).to(haveCount(3))
                    expect(loadingStates).to(equal([false, true, false]))
                }
            }
        }
    }
}
