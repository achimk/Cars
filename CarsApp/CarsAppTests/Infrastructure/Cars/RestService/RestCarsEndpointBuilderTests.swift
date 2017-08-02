//
//  RestCarsEndpointBuilderTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class RestCarsEndpointBuilderTests: XCTestCase {

    func testCreateURL() {
        let builder = RestCarsEndpointBuilder()

        do {
            let url = try builder.create(RestCarsEndpoint.cars)
            expect(url.absoluteString).to(equal("https://iteotest-bb88.restdb.io/rest/cars"))

        } catch {
            fail("Should never happen")
        }

    }
}
