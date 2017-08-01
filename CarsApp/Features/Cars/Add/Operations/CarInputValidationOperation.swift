//
//  CarInputValidationOperation.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

struct CarInputValidationOperation: ObservableConvertibleType {
    private let inputs: Array<CarInputViewModelType>

    init(_ inputs: Array<CarInputViewModelType>) {
        self.inputs = inputs
    }

    func asObservable() -> Observable<Bool> {
        let signals = inputs.map {
            $0.outputs.onTextResult.asObservable().map { $0.isSuccess }
        }

        return Observable.combineLatest(signals) { (items) -> Bool in
                return items.reduce(true, { (result, value) -> Bool in
                    return result && value
                })
            }
            .distinctUntilChanged()
    }
    
}
