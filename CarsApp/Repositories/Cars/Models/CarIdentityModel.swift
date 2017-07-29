//
//  CarIdentityModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct CarIdentityModel: Equatable {
    let id: String

    init(_ id: String) {
        self.id = id
    }
}

func ==(lhs: CarIdentityModel, rhs: CarIdentityModel) -> Bool {
    return lhs.id == rhs.id
}
