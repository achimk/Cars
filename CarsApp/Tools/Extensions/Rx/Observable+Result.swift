//
//  Observable+Result.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result
import RxSwift

extension Observable {
    func mapResult() -> Observable<Result<Element, AnyError>> {
        return map { element in
            return Result.success(element)
        }
        .catchError { (error) -> Observable<Result<Element, AnyError>> in
            let result = Result<Element, AnyError>(error: AnyError(error))
            return Observable<Result<Element, AnyError>>.just(result)
        }
    }

    func mapCarsServiceResult() -> Observable<Result<Element, CarsServiceError>> {
        return map { element in
            return Result.success(element)
        }
        .catchError { (error) -> Observable<Result<Element, CarsServiceError>> in
            if let error = error as? CarsServiceError {
                let result = Result<Element, CarsServiceError>(error: error)
                return Observable<Result<Element, CarsServiceError>>.just(result)
            } else {
                let result = Result<Element, CarsServiceError>(error: CarsServiceError.unknown(error))
                return Observable<Result<Element, CarsServiceError>>.just(result)
            }
        }
    }
}
