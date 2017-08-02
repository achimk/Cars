//
//  AddCarMockDispatcher.swift
//  CarsApp
//
//  Created by Joachim Kret on 02/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
@testable import CarsApp

final class AddCarMockDispatcher: ConditionCarsMockDispatcher {
    typealias ResponseType = Dictionary<String, Any>

    static func success() -> NetworkDispatcherType {

        let response = createResponse()
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

    private static func createResponse() -> ResponseType {
        return [
            "_id" : "123",
            "name" : "Name",
            "model" : "Model",
            "brand" : "Brand",
            "year" : "1234",
            "_created" : "CreatedTimestamp",
            "_changed" : "ChangedTimestamp",
            "_tags" : "tag1 tag2 tag3",
            "_version" : "1"
        ]
    }
}
