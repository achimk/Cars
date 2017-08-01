//
//  ConditionPresenterTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
@testable import CarsApp

final class ConditionPresenterTests: QuickSpec {

    override func spec() {

        describe("Condition Presenter") {

            context("Initialize with clousure") {

                it("Should call clousures") {

                    var present = false
                    var dissmiss = false
                    let viewController = UIViewController()
                    let onPresent: ((UIViewController) -> Void) = { _ in present = true }
                    let onDismiss: ((Void) -> Void) = { dissmiss = true }
                    let presenter = ConditionPresenter(onPresent: onPresent, onDismiss: onDismiss)

                    expect(present).to(beFalse())

                    presenter.present(viewController)

                    expect(present).to(beTrue())

                    expect(dissmiss).to(beFalse())

                    presenter.dismiss()

                    expect(dissmiss).to(beTrue())
                }
            }
        }
    }
}
