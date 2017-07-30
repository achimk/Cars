//
//  MockCarsServiceFactoryTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import CarsApp

final class MocksCarsServiceFactoryTests: QuickSpec {

    override func spec() {

        describe("Mocks Cars Service Factory") {

            context("Create service") {

                it("Should returns 3 items") {
                    let service = MocksCarsServiceFactory.create()

                    do {
                        let results = try service
                            .requestCarsList()
                            .toBlocking()
                            .single()

                        expect(results).to(haveCount(3))

                    } catch {
                        fail("Should never happen")
                    }
                }
            }
        }
    }
}
