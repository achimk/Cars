//
//  CarsListFlow.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

struct CarsListFlow: FlowPresentable {
    let navigationService: NavigationServiceType
    let listService: CarsListServiceType

    init(navigationService: NavigationServiceType,
         listService: CarsListServiceType) {

        self.navigationService = navigationService
        self.listService = listService
    }

    func present(using presenter: ViewControllerPresentable) {

        // FIXME: Implement

        let viewController = CarsListViewController(service: listService, onSelectCallback: nil)
        viewController.title = "List"
        presenter.present(viewController)
    }
    
}
