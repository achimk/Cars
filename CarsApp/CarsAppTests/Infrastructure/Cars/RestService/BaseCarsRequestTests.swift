//
//  BaseCarsRequestTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class BaseCarsRequestTests: XCTestCase {

    func testDefaultVariables() {
        let url = URL(string: "https://iteotest-bb88.restdb.io")!
        let request = BaseCarsRequest(url: url)

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "x-apikey": "5971d097a63f5e835a5df7bd"
        ]

        expect(request.url.absoluteString).to(equal(url.absoluteString))
        expect(request.method).to(equal(HTTPMethod.get))
        expect(request.parameters.keys).to(haveCount(0))
        expect(request.headers).to(equal(headers))
    }
}
