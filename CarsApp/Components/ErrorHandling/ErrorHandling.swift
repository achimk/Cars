//
//  ErrorHandling.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol ErrorHandling {
    func can(handle error: Error) -> Bool
}
