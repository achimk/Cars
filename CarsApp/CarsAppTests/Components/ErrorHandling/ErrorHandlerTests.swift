//
//  ErrorHandlerTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class ErrorHandlerTests: XCTestCase {

    private class InternalErrorHandler: ErrorHandlingChainable {
        init() { }
    }

    func testErrorHandlerCanHandle() {

        let handler = ErrorHandler { (error) -> Bool in
            return true
        }

        let error = CarsServiceError.cantConnect

        expect(handler.can(handle: error)).to(beTrue())
    }

    func testErrorHandlerCanNotHandle() {

        let handler = ErrorHandler { (error) -> Bool in
            return false
        }

        let error = CarsServiceError.cantConnect

        expect(handler.can(handle: error)).to(beFalse())
    }

    func testErrorHandlerChainOnSuccess() {

        var travel: Array<Error> = []
        let handler1 = ErrorHandler { (error) -> Bool in
            travel.append(error)
            return false
        }

        let handler2 = ErrorHandler { (error) -> Bool in
            travel.append(error)
            return true
        }

        let handler3 = ErrorHandler { (error) -> Bool in
            travel.append(error)
            return false
        }

        handler1.next = handler2
        handler2.next = handler3

        let error = CarsServiceError.cantConnect

        expect(handler1.can(handle: error)).to(beTrue())
        expect(travel).to(haveCount(2))
    }

    func testErrorHandlerChainOnFailure() {

        var travel: Array<Error> = []
        let handler1 = ErrorHandler { (error) -> Bool in
            travel.append(error)
            return false
        }

        let handler2 = ErrorHandler { (error) -> Bool in
            travel.append(error)
            return false
        }

        let handler3 = ErrorHandler { (error) -> Bool in
            travel.append(error)
            return false
        }

        handler1.next = handler2
        handler2.next = handler3

        let error = CarsServiceError.cantConnect

        expect(handler1.can(handle: error)).to(beFalse())
        expect(travel).to(haveCount(3))
    }

    func testErrorHandlerChainShouldNotModifyError() {

        let handler1 = ErrorHandler { (error) -> Bool in
            return false
        }

        let handler2 = ErrorHandler { (error) -> Bool in
            return false
        }

        let handler3 = ErrorHandler { (error) -> Bool in
            return false
        }

        var lastError: Error?
        let last = ErrorHandler { (error) -> Bool in
            lastError = error
            return true
        }

        handler1.next = handler2
        handler2.next = handler3
        handler3.next = last

        let error = CarsServiceError.cantConnect

        expect(lastError).to(beNil())
        expect(handler1.can(handle: error)).to(beTrue())
        expect(lastError).toNot(beNil())
        expect(lastError as? CarsServiceError).to(equal(CarsServiceError.cantConnect))
    }

    func testLastErrorHandler() {

        let handler1 = ErrorHandler { (error) -> Bool in
            return false
        }

        let handler2 = ErrorHandler { (error) -> Bool in
            return false
        }

        let handler3 = ErrorHandler { (error) -> Bool in
            return false
        }

        let last = ErrorHandler { (error) -> Bool in
            return true
        }

        handler1.next = handler2
        handler2.next = handler3
        handler3.next = last

        let error = CarsServiceError.cantConnect
        var handler = handler1.last()

        expect(handler.can(handle: error)).to(beTrue())

        handler = handler2.last()

        expect(handler.can(handle: error)).to(beTrue())

        handler = handler3.last()

        expect(handler.can(handle: error)).to(beTrue())

        handler = last.last()

        expect(handler.can(handle: error)).to(beTrue())
    }

    func testDefaultImplementation() {

        let handler = InternalErrorHandler()
        let error = CarsServiceError.cantConnect

        expect(handler.can(handle: error)).to(beFalse())
        expect(handler.next).to(beNil())
        expect(handler.last() === handler).to(beTrue())
    }
}
