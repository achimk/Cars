//
//  NetworkTask.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

class NetworkTask<I, O>: NetworkTaskType {
    typealias Input = I
    typealias Output = O
    let dispatcher: NetworkDispatcherType

    init(dispatcher: NetworkDispatcherType) {
        self.dispatcher = dispatcher
    }

    func perform(_ input: Input) -> Observable<Output> {
        // Subclasses should override this method!
        return Observable.empty()
    }
}
