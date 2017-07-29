//
//  RouteError.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

enum RouteError: Error {
    case notFound(LocationType)
    case invalidArguments(LocationType)
    case invalidPayload(LocationType)
    case unknown(LocationType, Error)
}
