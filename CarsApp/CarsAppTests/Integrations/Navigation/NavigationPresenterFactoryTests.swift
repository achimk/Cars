//
//  NavigationPresenterFactoryTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
@testable import CarsApp

final class NavigationPresenterFactoryTests: QuickSpec {

    override func spec() {

        describe("Navigation Presenter Factory") {

            context("Default initialization used") {

                var factory: NavigationPresenterFactory!

                beforeEach {
                    factory = NavigationPresenterFactory()
                }

                it("Creates window and navigation controller by default", closure: {

                    expect(factory.window).toNot(beNil())
                    expect(factory.navigationController).toNot(beNil())
                })

                it("Creates presenter", closure: {

                    let presenter = factory.createPresenter()
                    expect(presenter).toNot(beNil())
                })
            }

            context("Initialized with parameters", {

                let window = UIWindow()
                let navigation = UINavigationController()
                var factory: NavigationPresenterFactory!

                beforeEach {
                    factory = NavigationPresenterFactory(window: window, navigation: navigation)
                }

                it("Uses injected parameters", closure: {

                    expect(factory.window).to(equal(window))
                    expect(factory.navigationController).to(equal(navigation))
                })

                it("Creates presenter", closure: {

                    let presenter = factory.createPresenter()
                    expect(presenter).toNot(beNil())
                })
            })

            context("Creates presenter", {

                let window = UIWindow()
                let navigation = UINavigationController()
                let factory = NavigationPresenterFactory(window: window, navigation: navigation)

                it("Presents always valid controller on window", closure: {

                    let viewController = UIViewController()
                    let presenter = factory.createPresenter()

                    expect(window.rootViewController).to(beNil())
                    expect(navigation.viewControllers).to(haveCount(0))

                    presenter.present(viewController)

                    expect(window.rootViewController).toNot(beNil())
                    expect(navigation.viewControllers).to(haveCount(1))

                    window.rootViewController = nil

                    expect(window.rootViewController).to(beNil())
                    expect(navigation.viewControllers).to(haveCount(1))
                    
                    presenter.present(viewController)
                    
                    expect(window.rootViewController).toNot(beNil())
                    expect(navigation.viewControllers).to(haveCount(1))
                })
                
            })
        }
    }
}
