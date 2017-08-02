//
//  AddCarTaskTests.swift
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

final class AddCarTaskTests: XCTestCase {

    func testResponseSuccess() {
        let dispatcher = AddCarMockDispatcher.success()
        let builder = RestCarsEndpointBuilder()

        let task = AddCarTask(
            dispatcher: dispatcher,
            endpointBuilder: builder
        )

        do {
            let body = CarBodyParameters(
                name: "",
                brand: "",
                model: "",
                year: ""
            )

            let result = try task
                .perform(body)
                .toBlocking()
                .single()

            expect(result).toNot(beNil())
            expect(result?.id).to(equal("123"))
            expect(result?.name).to(equal("Name"))
            expect(result?.model).to(equal("Model"))
            expect(result?.brand).to(equal("Brand"))
            expect(result?.year).to(equal("1234"))
            expect(result?.createdTimestamp).to(equal("CreatedTimestamp"))
            expect(result?.changedTimestamp).to(equal("ChangedTimestamp"))
            expect(result?.tags).to(equal("tag1 tag2 tag3"))
            expect(result?.version).to(equal("1"))

        } catch {
            fail("Should never happen")
        }
    }

    func testResponseFailure() {
        let dispatcher = AddCarMockDispatcher.failure()
        let builder = RestCarsEndpointBuilder()

        let task = AddCarTask(
            dispatcher: dispatcher,
            endpointBuilder: builder
        )

        do {
            let body = CarBodyParameters(
                name: "",
                brand: "",
                model: "",
                year: ""
            )

            let _ = try task
                .perform(body)
                .toBlocking()
                .single()

            fail("Should never happen")

        } catch {
            expect(error).toNot(beNil())
        }
    }

}
