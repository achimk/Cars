//
//  RetryErrorPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct RetryErrorPresenterSpecs {
    let cancelTitle: String
    let retryTitle: String
    let onDissmissCallback: ((Void) -> Void)?
}

final class RetryErrorPresenter: ErrorPresenterType, ErrorPresenterFactoryType {

    weak var sourceViewController: UIViewController?
    var currentAlert: UIAlertController?
    let parser: ErrorMessageParserType
    let specs: RetryErrorPresenterSpecs
    var next: ErrorHandlingChainable?

    static func create(using contextController: UIViewController?) -> ErrorPresenterType {

        let specs = RetryErrorPresenterSpecs(
            cancelTitle: NSLocalizedString("Cancel", comment: "Cancel button"),
            retryTitle: NSLocalizedString("Retry", comment: "Retry button"),
            onDissmissCallback: nil
        )

        let presenter = RetryErrorPresenter(parser: ErrorMessageParser(), specs: specs)
        presenter.sourceViewController = contextController

        return presenter
    }

    init(parser: ErrorMessageParserType, specs: RetryErrorPresenterSpecs) {
        self.parser = parser
        self.specs = specs
    }

    func present(with error: Error) {
        let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: "Error title"),
            message: parser.parse(error),
            preferredStyle: UIAlertControllerStyle.alert
        )

        let retry = UIAlertAction(
            title: specs.retryTitle,
            style: UIAlertActionStyle.default,
            handler: { [weak self] action in
                self?.dismiss()
                let _ = self?.can(handle: error)
            })

        let cancel = UIAlertAction(
            title: specs.cancelTitle,
            style: UIAlertActionStyle.destructive,
            handler: { [weak self] _ in
                self?.dismiss()
            })

        alert.addAction(retry)
        alert.addAction(cancel)

        currentAlert = alert
        sourceViewController?.present(alert, animated: true, completion: nil)
    }

    func dismiss() {
        currentAlert?.dismiss(animated: true, completion: { [weak self] in
            self?.specs.onDissmissCallback?()
            self?.currentAlert = nil
        })
    }
}
