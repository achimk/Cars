//
//  CarInputWhitespaceTrimmerTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class CarInputWhitespaceTrimmerTests: XCTestCase {

    func testConverter() {
        let converter = CarInputWhitespaceTrimmer.create()

        expect(converter.run(" ")).to(equal(""))
        expect(converter.run(" a ")).to(equal("a"))
        expect(converter.run(" a a ")).to(equal("a a"))
        expect(converter.run("   a   a   ")).to(equal("a   a"))
    }
}
