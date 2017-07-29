//
//  ViewControllerPresenterTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
@testable import CarsApp

final class ViewControllerPresenterTests: QuickSpec {

    override func spec() {

        describe("View Controller Presenter") { 

            context("Initialize with clousure") {

                it("Should call clousure") {

                    var fallback = false
                    let viewController = UIViewController()
                    let presenter = ViewControllerPresenter { viewController in
                        fallback = true
                    }

                    expect(fallback).to(beFalse())

                    presenter.present(viewController)

                    expect(fallback).to(beTrue())
                }
            }
        }
    }
}
