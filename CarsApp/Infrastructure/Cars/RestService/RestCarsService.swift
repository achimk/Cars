//
//  RestCarsService.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class RestCarsService: NetworkDispatcher {

    override func execute(_ request: NetworkRequestType) -> Observable<Any> {
        let operation = Alamofire.request(
            request.url,
            method: httpMethod(from: request),
            parameters: request.parameters,
            encoding: URLEncoding(destination: .httpBody),
            headers: request.headers
        )

        return createRequest(from: operation)
    }

    private func createRequest(from operation: Alamofire.DataRequest) -> Observable<Any> {
        return Observable.create {
            (observer: AnyObserver<Any>) -> Disposable in

            operation
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON(completionHandler: { (response) in

                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()

                    case .failure(let error):
                        observer.onError(error)
                    }
                })

            return Disposables.create()
        }
    }

    private func httpMethod(from request: NetworkRequestType) -> Alamofire.HTTPMethod {
        switch request.method {
        case .get: return Alamofire.HTTPMethod.get
        case .post: return Alamofire.HTTPMethod.post
        }
    }
}