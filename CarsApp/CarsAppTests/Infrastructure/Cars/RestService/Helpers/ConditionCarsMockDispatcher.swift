//
//  ConditionCarsMockDispatcher.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
@testable import CarsApp

class ConditionCarsMockDispatcher: NetworkDispatcherType {
    private let callback: ((Void) -> Observable<Any>)

    init(_ callback: @escaping ((Void) -> Observable<Any>)) {
        self.callback = callback
    }

    func execute(_ request: NetworkRequestType) -> Observable<Any> {
        return callback()
    }
}
