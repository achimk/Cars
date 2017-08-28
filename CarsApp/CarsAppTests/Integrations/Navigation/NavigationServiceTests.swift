//
//  NavigationServiceTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
@testable import CarsApp

final class NavigationServiceTests: QuickSpec {

    override func spec() {

        describe("Navigation Service") {

            context("Used as factory", {

                var service: NavigationServiceType!
                var presenter: NavigationPresenter!

                beforeEach {
                    service = NavigationService.create()
                    presenter = NavigationPresenter(navigationController: UINavigationController())
                }

                it("Can navigate to cars list", closure: { 

                    expect(presenter.navigationController.viewControllers).to(haveCount(0))

                    let location = Navigation.Route.carsList.asLocation()
                    service.navigate(to: location, using: presenter)

                    expect(presenter.navigationController.viewControllers).to(haveCount(1))
                })

                it("Can navigate to car add", closure: {

                    expect(presenter.navigationController.viewControllers).to(haveCount(0))

                    let payload = CarAddRoutePayload(completion: nil)
                    let location = Navigation.Route.carAdd(payload).asLocation()
                    service.navigate(to: location, using: presenter)

                    expect(presenter.navigationController.viewControllers).to(haveCount(1))
                })

                it("Can navigate to car details", closure: {

                    expect(presenter.navigationController.viewControllers).to(haveCount(0))

                    let payload = CarDetailsRoutePayload(identity: CarIdentityModel("1"))
                    let location = Navigation.Route.carDetails(payload).asLocation()
                    service.navigate(to: location, using: presenter)

                    expect(presenter.navigationController.viewControllers).to(haveCount(1))
                })

                it("Should not navigate to any page when location is not handled") {

                    expect(presenter.navigationController.viewControllers).to(haveCount(0))

                    let location = Location(scheme: Navigation.scheme, path: "PathWhichNeverBeDispatched!")
                    service.navigate(to: location, using: presenter)

                    expect(presenter.navigationController.viewControllers).to(haveCount(0))
                }
            })

        }
    }
}
