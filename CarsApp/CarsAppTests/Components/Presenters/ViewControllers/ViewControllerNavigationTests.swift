//
//  ViewControllerNavigationTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 06/09/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
@testable import CarsApp

final class ViewControllerNavigationTests: QuickSpec {

    override func spec() {

        describe("ViewControllerNavigationType types") {

            context("Chained stack of navigation presenters") {
                
                var first: ViewControllerNavigationType!
                var middle: ViewControllerNavigationType!
                var last: ViewControllerNavigationType!

                beforeEach {
                    let presenter1 = NavigationPresenter(
                        parent: nil,
                        navigationController: UINavigationController(),
                        animated: false
                    )

                    let presenter2 = NavigationPresenter(
                        parent: presenter1,
                        navigationController: UINavigationController(),
                        animated: false
                    )

                    let presenter3 = NavigationPresenter(
                        parent: presenter2,
                        navigationController: UINavigationController(),
                        animated: false
                    )

                    first = presenter1
                    middle = presenter2
                    last = presenter3
                }


                it("Can be enumerated") {

                    let enumeratedFromLast = Array(last.iterator())
                    expect(enumeratedFromLast).to(haveCount(3))

                    let enumeratedFromMiddle = Array(middle.iterator())
                    expect(enumeratedFromMiddle).to(haveCount(2))

                    let enumeratedFromFirst = Array(first.iterator())
                    expect(enumeratedFromFirst).to(haveCount(1))
                }

                it("Can navigate to root") {

                    var root = last.root()
                    expect(root.viewController === first.viewController).to(beTrue())

                    root = middle.root()
                    expect(root.viewController === first.viewController).to(beTrue())

                    root = first.root()
                    expect(root.viewController === first.viewController).to(beTrue())
                }

                it("Can find first controller in chain") {

                    var chainController = last.firstChainController()
                    expect(last.viewController === chainController).to(beTrue())

                    chainController = middle.firstChainController()
                    expect(middle.viewController === chainController).to(beTrue())

                    chainController = first.firstChainController()
                    expect(first.viewController === chainController).to(beTrue())
                }

                it("Can find last controller in chain") {

                    var chainController = last.lastChainController()
                    expect(first.viewController === chainController).to(beTrue())

                    chainController = middle.lastChainController()
                    expect(first.viewController === chainController).to(beTrue())

                    chainController = first.lastChainController()
                    expect(first.viewController === chainController).to(beTrue())
                }

                it("Enumerate in correct order") {
                    
                    let correctOrder = [
                        last,
                        middle,
                        first
                    ]

                    let enumeratedFromLast = Array(last.iterator())

                    for (index, presenter) in enumeratedFromLast.enumerated() {
                        expect(presenter.viewController === correctOrder[index]?.viewController).to(beTrue())
                    }
                }
            }
        }
    }
}
