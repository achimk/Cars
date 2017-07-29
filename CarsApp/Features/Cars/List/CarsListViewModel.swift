//
//  CarsListViewModel.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol CarsListViewModelInputs {

}

protocol CarsListViewModelOutputs {

}

protocol CarsListViewModelType {
    var inputs: CarsListViewModelInputs { get }
    var outputs: CarsListViewModelOutputs { get }
}

final class CarsListViewModel: CarsListViewModelType {
    let service: CarsListServiceType

    var inputs: CarsListViewModelInputs { return self }
    var outputs: CarsListViewModelOutputs { return self }

    init(service: CarsListServiceType) {
        self.service = service
    }
}

extension CarsListViewModel: CarsListViewModelInputs {

}

extension CarsListViewModel: CarsListViewModelOutputs {

}
