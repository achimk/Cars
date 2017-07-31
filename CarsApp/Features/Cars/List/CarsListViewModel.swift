//
//  CarsListViewModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result

typealias CarsListResult = Result<Array<CarsListItemPresentable>, CarsServiceError>

protocol CarsListViewModelInputs {
    func fetch()
}

protocol CarsListViewModelOutputs {
    var onPresentResult: Driver<CarsListResult> { get }
    var onLoading: Driver<Bool> { get }
}

protocol CarsListViewModelType {
    var inputs: CarsListViewModelInputs { get }
    var outputs: CarsListViewModelOutputs { get }
}

final class CarsListViewModel: CarsListViewModelType {

    fileprivate let signalFetch: PublishSubject<Void>
    fileprivate let signalRequest: ObservableProbe
    fileprivate let driverPresentResult: Driver<CarsListResult>

    var inputs: CarsListViewModelInputs { return self }
    var outputs: CarsListViewModelOutputs { return self }

    init(service: CarsListServiceType) {

        let trigger = PublishSubject<Void>()
        let probe = ObservableProbe()

        signalFetch = trigger
        signalRequest = probe

        driverPresentResult = trigger
            .withLatestFrom(probe)
            .filter { !$0 }
            .flatMapLatest { _ in
                return service
                    .requestCarsList()
                    .take(1)
                    .map {
                        $0.map { CarsListPresentationItem($0) as CarsListItemPresentable }
                    }
                    .trackActivity(probe)
                    .mapCarsServiceResult()
            }
            .asDriver(onErrorDriveWith: Driver.never())
    }

    deinit {
        print("[*] \(type(of: self)): \(#function)")
    }
}

extension CarsListViewModel: CarsListViewModelInputs {
    func fetch() {
        signalFetch.onNext()
    }
}

extension CarsListViewModel: CarsListViewModelOutputs {
    var onPresentResult: Driver<CarsListResult> {
        return driverPresentResult
    }

    var onLoading: Driver<Bool> {
        return signalRequest.asDriver()
    }
}
