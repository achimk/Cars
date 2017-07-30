//
//  ErrorPresenterTests.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import XCTest
import Nimble
@testable import CarsApp

final class ErrorPresenterTests: XCTestCase {

    private final class InternalErrorPresenter: ErrorPresenterType {
        init() { }
        func present(with error: Error) { }
        func dismiss() { }
    }

    func testPresentErrorShouldHandleError() {

        var isPresented = false
        var isDismissed = false
        var isHandled = false

        let onPresent: ErrorPresenter.PresentCallback = { (error, callback) in
            isPresented = true
            callback(true)
        }

        let onDissmiss: ErrorPresenter.DismissCallback = {
            isDismissed = true
        }

        let presenter = ErrorPresenter(onPresent: onPresent, onDismiss: onDissmiss)
        presenter.next = ErrorHandler { _ in
            isHandled = true
            return true
        }

        expect(isPresented).to(beFalse())
        expect(isDismissed).to(beFalse())
        expect(isHandled).to(beFalse())

        let error = CarsServiceError.cantConnect
        presenter.present(with: error)

        expect(isPresented).to(beTrue())
        expect(isDismissed).to(beFalse())
        expect(isHandled).to(beTrue())

        presenter.dismiss()

        expect(isPresented).to(beTrue())
        expect(isDismissed).to(beTrue())
        expect(isHandled).to(beTrue())
    }

    func testPresnetErrorShouldNotHandleError() {

        var isPresented = false
        var isDismissed = false
        var isHandled = false

        let onPresent: ErrorPresenter.PresentCallback = { (error, callback) in
            isPresented = true
            callback(false)
        }

        let onDissmiss: ErrorPresenter.DismissCallback = {
            isDismissed = true
        }

        let presenter = ErrorPresenter(onPresent: onPresent, onDismiss: onDissmiss)
        presenter.next = ErrorHandler { _ in
            isHandled = true
            return true
        }

        expect(isPresented).to(beFalse())
        expect(isDismissed).to(beFalse())
        expect(isHandled).to(beFalse())

        let error = CarsServiceError.cantConnect
        presenter.present(with: error)

        expect(isPresented).to(beTrue())
        expect(isDismissed).to(beFalse())
        expect(isHandled).to(beFalse())

        presenter.dismiss()

        expect(isPresented).to(beTrue())
        expect(isDismissed).to(beTrue())
        expect(isHandled).to(beFalse())
    }

    func testDefaultImplementation() {

        let presenter = InternalErrorPresenter()
        let error = CarsServiceError.cantConnect

        expect(presenter.can(handle: error)).to(beFalse())
        expect(presenter.last() === presenter).to(beTrue())
    }
}
