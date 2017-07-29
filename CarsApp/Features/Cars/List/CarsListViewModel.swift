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

protocol CarsListViewModelInputs {
    func fetch()
}

protocol CarsListViewModelOutputs {
    var onPresentItems: Driver<Array<CarsListItemPresentable>> { get }
    var onPresentError: Driver<CarsServiceError> { get }
}

protocol CarsListViewModelType {
    var inputs: CarsListViewModelInputs { get }
    var outputs: CarsListViewModelOutputs { get }
}

final class CarsListViewModel: CarsListViewModelType {
    let signalFetch: PublishSubject<Void>
    let driverPresentItems: Driver<Array<CarsListItemPresentable>>
//    let driverPresentError: Driver<CarsServiceError>

    var inputs: CarsListViewModelInputs { return self }
    var outputs: CarsListViewModelOutputs { return self }

    init(service: CarsListServiceType) {
        let trigger = PublishSubject<Void>()
        signalFetch = trigger
        driverPresentItems = trigger
            .flatMapLatest {
                return service.requestCarsList().take(1)
            }
            .map {
                $0.map { CarsListPresentationItem($0) as CarsListItemPresentable }
            }
            .asDriver(onErrorDriveWith: Driver.never())
    }
}

extension CarsListViewModel: CarsListViewModelInputs {
    func fetch() {
        signalFetch.onNext()
    }
}

extension CarsListViewModel: CarsListViewModelOutputs {
    var onPresentItems: Driver<Array<CarsListItemPresentable>> {
        return driverPresentItems
    }

    var onPresentError: Driver<CarsServiceError> {
        return Driver.empty()
    }
}
