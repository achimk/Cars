//
//  RestCarsEndpointBuilder.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct RestCarsEndpointBuilder: RestCarsEndpointBuilderType {

    init() { }

    func create(_ endpoint: RestCarsEndpoint) throws -> URL {
        if let url = URL(string: RestCars.baseURLString + endpoint.rawValue) {
            return url
        }

        throw RestCarsServiceError.invalidURL
    }
}
