//
//  AddCarTask.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

struct CarBodyParameters {
    let name: String
    let brand: String
    let model: String
    let year: String

    init(name: String,
         brand: String,
         model: String,
         year: String) {

        self.name = name
        self.brand = brand
        self.model = model
        self.year = year
    }
}

final class AddCarTask: BaseCarsTask<CarBodyParameters, CarCreateModelResponse> {
    typealias ContentResponse = Dictionary<String, Any>

    override func perform(_ input: CarBodyParameters) -> Observable<CarCreateModelResponse> {
        let dispatcher = self.dispatcher

        let recognizer: ((Any) throws -> ContentResponse) = { response in
            if let content = response as? ContentResponse {
                return content
            }

            throw RestCarsServiceError.invalidResponse
        }

        let mapper: ((ContentResponse) throws -> CarCreateModelResponse) = { content in
            let model = Mapper<CarCreateModelResponse>().map(JSONObject: content)

            switch model {
            case .some(let result): return result
            case .none: throw RestCarsServiceError.invalidResponse
            }
        }

        let parameters = createParameters(input)
        let completion: ((BaseCarsRequest) -> Void) = { request in
            request.parameters = parameters
        }

        return createRequest(endpoint: .cars, completion: completion)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .flatMap { dispatcher.execute($0) }
            .map(recognizer)
            .map(mapper)
            .observeOn(MainScheduler.asyncInstance)
    }

    private func createParameters(_ model: CarBodyParameters) -> Parameters {
        return [
            "name" : model.name,
            "model" : model.model,
            "brand" : model.brand,
            "year" : model.year
        ]
    }

}
