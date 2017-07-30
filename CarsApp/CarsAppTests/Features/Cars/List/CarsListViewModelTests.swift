//
//  CarsListViewModelTests.swift
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

final class CarsListViewModelTests: QuickSpec {

    override func spec() {

        describe("Cars List View Model") { 

            context("Initialized with error service") {

                let service: CarsServiceType = ErrorCarsService(error: .cantConnect)
                let vm: CarsListViewModelType = CarsListViewModel(service: service)
                let bag = DisposeBag()

                it("Should present error") {

                    var loadingStates: Array<Bool> = []
                    var output: CarsListResult?

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
                let vm: CarsListViewModelType = CarsListViewModel(service: service)
                let bag = DisposeBag()

                it("Should present items") {

                    var loadingStates: Array<Bool> = []
                    var output: CarsListResult?

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
                    expect(output?.value).to(haveCount(3))
                    expect(loadingStates).to(haveCount(3))
                    expect(loadingStates).to(equal([false, true, false]))
                }
            }
        }
    }
}
