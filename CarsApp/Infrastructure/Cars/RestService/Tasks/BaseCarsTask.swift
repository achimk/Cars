//
//  BaseCarsTask.swift
//  CarsApp
//
//  Created by Joachim Kret on 01/08/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift

class BaseCarsTask<I, O>: NetworkTask<I, O> {
    let endpointBuilder: RestCarsEndpointBuilderType

    init(dispatcher: NetworkDispatcherType, endpointBuilder: RestCarsEndpointBuilderType) {
        self.endpointBuilder = endpointBuilder
        super.init(dispatcher: dispatcher)
    }

    func createRequest(
        endpoint: RestCarsEndpoint,
        completion: ((BaseCarsRequest) -> Void)? = nil) -> Observable<NetworkRequestType> {

        let builder = endpointBuilder
        return Observable.create({ (observer: AnyObserver<NetworkRequestType>) -> Disposable in
            do {
                let url = try builder.create(endpoint)
                let request = BaseCarsRequest(url: url)
                completion?(request)
                observer.onNext(request)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        })
    }
}
