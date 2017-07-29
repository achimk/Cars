//
//  WindowPresenterTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
@testable import CarsApp

final class WindowPresenterTests: QuickSpec {

    override func spec() {

        describe("Window Presenter") {

            context("Initialize with window", closure: {

                it("Can present view controller", closure: {

                    let window = UIWindow()
                    let presenter = WindowPresenter(window)
                    let viewController = UIViewController()

                    expect(window.rootViewController).to(beNil())

                    presenter.present(viewController)

                    expect(window.rootViewController).toNot(beNil())
                })
            })
        }
    }
}
