//
//  CarsServiceError.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

enum CarsServiceError: Error, Equatable {
    case notFound
    case unknown(Error)
}

func ==(lhs: CarsServiceError, rhs: CarsServiceError) -> Bool {
    switch (lhs, rhs) {
    case (.notFound, .notFound): return true
    case (.unknown, .unknown): return true
    default: return false
    }
}
