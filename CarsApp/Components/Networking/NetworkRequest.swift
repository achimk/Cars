//
//  NetworkRequest.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

struct NetworkRequest: NetworkRequestType {
    var url: URL
    var method: HTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders

    init(url: URL,
         method: HTTPMethod,
         parameters: Parameters = [:],
         headers: HTTPHeaders = [:]) {

        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}
