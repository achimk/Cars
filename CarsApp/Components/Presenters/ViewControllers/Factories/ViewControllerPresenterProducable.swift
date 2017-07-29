//
//  ViewControllerPresenterProducable.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

protocol ViewControllerPresenterProducable {
    func createPresenter() -> ViewControllerPresentable
}
