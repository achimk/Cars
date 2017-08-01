//
//  RestCarsServiceError.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

enum RestCarsServiceError: Error {
    case invalidURL
    case invalidResponse
    case internalError(Error)
}
