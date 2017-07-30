//
//  ErrorPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

final class ErrorPresenter: ErrorPresenterType {
    typealias Completion = ((Bool) -> Void)
    typealias PresentCallback = ((Error, Completion) -> Void)
    typealias DismissCallback = ((Void) -> Void)

    private let presentCallback: PresentCallback
    private let dismissCallback: DismissCallback

    var next: ErrorHandlingChainable?

    static func nopPresenter() -> ErrorPresenter {
        return ErrorPresenter(onPresent: { (_, _) in })
    }

    init(onPresent: @escaping PresentCallback, onDismiss: @escaping DismissCallback = { }) {
        self.presentCallback = onPresent
        self.dismissCallback = onDismiss
    }

    func present(with error: Error) {
        let completion: Completion = { [weak self] shouldHandle in
            if shouldHandle {
                let _ = self?.can(handle: error)
            }
        }
        presentCallback(error, completion)
    }

    func dismiss() {
        dismissCallback()
    }
}
