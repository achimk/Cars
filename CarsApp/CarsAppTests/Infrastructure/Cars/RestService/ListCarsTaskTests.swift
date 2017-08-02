//
//  ListCarsTaskTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
import RxSwift
import RxBlocking
@testable import CarsApp

final class ListCarsTaskTests: XCTestCase {

    func testResponseSuccess() {
        let dispatcher = ListCarsMockDispatcher.success()
        let builder = RestCarsEndpointBuilder()

        let task = ListCarsTask(
            dispatcher: dispatcher,
            endpointBuilder: builder
        )

        do {

            let result = try task
                .perform()
                .toBlocking()
                .single()

            expect(result).toNot(beNil())
            expect(result).to(haveCount(3))

            for index in 0 ..< 3 {
                expect(result?[index].id).to(equal("\(index)"))
                expect(result?[index].name).to(equal("Name \(index)"))
                expect(result?[index].model).to(equal("Model"))
                expect(result?[index].brand).to(equal("Brand"))
                expect(result?[index].year).to(equal("1234"))
            }

        } catch {
            fail("Should never happen")
        }
    }

    func testResponseFailure() {
        let dispatcher = ListCarsMockDispatcher.failure()
        let builder = RestCarsEndpointBuilder()

        let task = ListCarsTask(
            dispatcher: dispatcher,
            endpointBuilder: builder
        )

        do {

            let _ = try task
                .perform()
                .toBlocking()
                .single()

            fail("Should never happen")

        } catch {
            expect(error).toNot(beNil())
        }
    }

    func testResponseEmpty() {
        let dispatcher = ListCarsMockDispatcher.empty()
        let builder = RestCarsEndpointBuilder()

        let task = ListCarsTask(
            dispatcher: dispatcher,
            endpointBuilder: builder
        )

        do {

            let result = try task
                .perform()
                .toBlocking()
                .single()

            expect(result).toNot(beNil())
            expect(result).to(haveCount(0))

        } catch {
            fail("Should never happen")
        }
    }
}
