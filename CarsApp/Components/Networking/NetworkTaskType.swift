//
//  NetworkTaskType.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkTaskType {
    associatedtype Input
    associatedtype Output
    func perform(_ input: Input) -> Observable<Output>
}
