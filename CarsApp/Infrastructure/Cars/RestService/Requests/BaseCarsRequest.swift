//
//  BaseCarsRequest.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

final class BaseCarsRequest: NetworkRequestType {
    let url: URL
    var method: HTTPMethod = .get
    var parameters: Parameters = [:]
    var headers: HTTPHeaders = [:]

    init(url: URL) {
        self.url = url
        self.headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "x-apikey": "5971d097a63f5e835a5df7bd"
        ]
    }
}
