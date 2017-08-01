//
//  NetworkDispatcher.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

class NetworkDispatcher: NetworkDispatcherType {

    init() { }

    func execute(_ request: NetworkRequestType) -> Observable<Any> {
        // Subclasses should override this method!
        return Observable.empty()
    }
}
