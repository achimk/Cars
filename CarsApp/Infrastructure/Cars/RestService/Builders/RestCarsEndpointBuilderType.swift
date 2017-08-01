//
//  RestCarsEndpointBuilderType.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol RestCarsEndpointBuilderType {
    func create(_ endpoint: RestCarsEndpoint) throws -> URL
}
