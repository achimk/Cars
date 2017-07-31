//
//  Result+Additions.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result

extension Result {
    var isSuccess: Bool {
        return analysis(
            ifSuccess: { _ in true },
            ifFailure: { _ in false }
        )
    }

    var isFailure: Bool {
        return !isSuccess
    }
}
