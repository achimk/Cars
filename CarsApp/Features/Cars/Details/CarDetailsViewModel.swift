//
//  CarDetailsViewModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result

typealias CarDetailsResult = Result<Array<CarDetailsItemPresentable>, CarsServiceError>

protocol CarDetailsViewModelInputs {
    func fetch()
}

protocol CarDetailsViewModelOutputs {
    var onPresentResult: Driver<CarDetailsResult> { get }
    var onLoading: Driver<Bool> { get }
}

protocol CarDetailsViewModelType {
    var inputs: CarDetailsViewModelInputs { get }
    var outputs: CarDetailsViewModelOutputs { get }
}

final class CarDetailsViewModel: CarDetailsViewModelType {

    fileprivate let signalFetch: PublishSubject<Void>
    fileprivate let signalRequest: ObservableProbe
    fileprivate let driverPresentResult: Driver<CarDetailsResult>

    var inputs: CarDetailsViewModelInputs { return self }
    var outputs: CarDetailsViewModelOutputs { return self }

    init(identity: CarIdentityModel, service: CarDetailsServiceType) {

        let trigger = PublishSubject<Void>()
        let probe = ObservableProbe()

        signalFetch = trigger
        signalRequest = probe

        driverPresentResult = trigger
            .withLatestFrom(probe)
            .filter { !$0 }
            .flatMapLatest { _ in
                return service
                    .requestCarDetails(using: identity)
                    .take(1)
                    .map { CarDetailsParametersMapper.map($0) }
                    .trackActivity(probe)
                    .mapCarsServiceResult()
            }
            .asDriver(onErrorDriveWith: Driver.never())
    }

    deinit {
        print("[*] \(type(of: self)): \(#function)")
    }
}

extension CarDetailsViewModel: CarDetailsViewModelInputs {
    func fetch() {
        signalFetch.onNext()
    }
}

extension CarDetailsViewModel: CarDetailsViewModelOutputs {
    var onPresentResult: Driver<CarDetailsResult> {
        return driverPresentResult
    }

    var onLoading: Driver<Bool> {
        return signalRequest.asDriver()
    }
}
