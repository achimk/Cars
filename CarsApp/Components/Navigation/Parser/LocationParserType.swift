//
//  LocationParserType.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol LocationParserType {
    func parse(url: URL, payload: Any?) -> LocationType
}

extension LocationParserType {
    final func parse(url: URL) -> LocationType {
        return parse(url: url, payload: nil)
    }
}
