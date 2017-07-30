//
//  AlertErrorPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct AlertErrorPresenterSpecs {
    let dismissTitle: String
    let onDissmissCallback: ((Void) -> Void)?
}

final class AlertErrorPresenter: ErrorPresenterType, ErrorPresenterFactoryType {

    weak var sourceViewController: UIViewController?
    var currentAlert: UIAlertController?
    let parser: ErrorMessageParserType
    let specs: AlertErrorPresenterSpecs

    static func create(using contextController: UIViewController?) -> ErrorPresenterType {
        let specs = AlertErrorPresenterSpecs(
            dismissTitle: NSLocalizedString("Dismiss", comment: "Dissmiss button"),
            onDissmissCallback: nil
        )

        let presenter = AlertErrorPresenter(parser: ErrorMessageParser(), specs: specs)
        presenter.sourceViewController = contextController

        return presenter
    }

    init(parser: ErrorMessageParserType, specs: AlertErrorPresenterSpecs) {
        self.parser = parser
        self.specs = specs
    }

    func present(with error: Error) {
        let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: "Error title"),
            message: parser.parse(error),
            preferredStyle: UIAlertControllerStyle.alert
        )

        let dismiss = UIAlertAction(
            title: specs.dismissTitle,
            style: UIAlertActionStyle.default,
            handler: { [weak self] _ in
                self?.dismiss()
            })

        alert.addAction(dismiss)

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
