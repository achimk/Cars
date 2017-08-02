//
//  ListCarsMockDispatcher.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
@testable import CarsApp

final class ListCarsMockDispatcher: ConditionCarsMockDispatcher {
    typealias ResponseType = Array<Dictionary<String, Any>>

    static func success() -> NetworkDispatcherType {

        let response = createResponse(count: 3)
        return ConditionCarsMockDispatcher {
            return Observable.just(response)
        }
    }


    static func failure() -> NetworkDispatcherType {

        return ConditionCarsMockDispatcher {
            let error = RestCarsServiceError.invalidResponse
            return Observable.error(error)
        }
    }

    static func empty() -> NetworkDispatcherType {

        return ConditionCarsMockDispatcher {
            let response: ResponseType = []
            return Observable.just(response)
        }
    }

    private static func createResponse(count: Int) -> ResponseType {
        var items: ResponseType = []

        for index in 0 ..< count {
            let json: Dictionary<String, Any> = [
                "_id" : "\(index)",
                "name" : "Name \(index)",
                "model" : "Model",
                "brand" : "Brand",
                "year" : "1234"
            ]

            items.append(json)
        }


        return items
    }
}
