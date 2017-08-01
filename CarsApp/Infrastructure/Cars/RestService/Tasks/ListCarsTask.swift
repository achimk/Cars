//
//  ListCarsTask.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

final class ListCarsTask: BaseCarsTask<Void, Array<CarModelResponse>> {
    typealias ContentResponse = Array<Dictionary<String, Any>>

    override func perform(_ input: ()) -> Observable<Array<CarModelResponse>> {
        let dispatcher = self.dispatcher

        let recognizer: ((Any) throws -> ContentResponse) = { response in
            if let content = response as? ContentResponse {
                return content
            }

            throw RestCarsServiceError.invalidResponse
        }

        let mapper: ((ContentResponse) -> Array<CarModelResponse>) = { content in
            return Mapper<CarModelResponse>().mapArray(JSONArray: content)
        }

        return createRequest(endpoint: .cars)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .flatMap { dispatcher.execute($0) }
            .map(recognizer)
            .map(mapper)
            .observeOn(MainScheduler.asyncInstance)
    }

}
