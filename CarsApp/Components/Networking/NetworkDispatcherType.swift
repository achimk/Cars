//
//  NetworkDispatcherType.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkDispatcherType {
    func execute(_ request: NetworkRequestType) -> Observable<Any>
}
