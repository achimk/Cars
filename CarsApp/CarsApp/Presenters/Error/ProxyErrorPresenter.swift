//
//  ProxyErrorPresenter.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

final class ProxyErrorPresenter: ErrorPresenterType {
    var proxy: ErrorPresenterType? {
        didSet {
            proxy?.next = oldValue?.next
        }
    }

    var next: ErrorHandlingChainable? {
        set { proxy?.next = newValue }
        get { return proxy?.next }
    }

    init(_ proxy: ErrorPresenterType? = nil) {
        self.proxy = proxy
    }

    func present(with error: Error) {
        proxy?.present(with: error)
    }

    func dismiss() {
        proxy?.dismiss()
    }
}
