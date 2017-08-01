//
//  NavigationPresenterTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
@testable import CarsApp

final class NavigationPresenterTests: QuickSpec {

    override func spec() {

        describe("Navigation Presenter") { 

            context("Initialize with navigation controller", closure: { 

                it("Can present and dismiss view controller", closure: {

                    let navigationController = UINavigationController()
                    let presenter = NavigationPresenter(navigationController)
                    let viewController = UIViewController()

                    expect(navigationController.viewControllers).to(haveCount(0))

                    presenter.present(viewController)

                    expect(navigationController.viewControllers).to(haveCount(1))

                    presenter.dismiss()

                    expect(navigationController.viewControllers).to(haveCount(0))
                })
            })
        }
    }
}
