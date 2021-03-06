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
    private let navigationService: NavigationServiceType
    private let listService: CarsListServiceType
    private let errorPresenter: ErrorPresenterType?

    init(navigationService: NavigationServiceType,
         listService: CarsListServiceType,
         errorPresenter: ErrorPresenterType?) {

        self.navigationService = navigationService
        self.listService = listService
        self.errorPresenter = errorPresenter
    }

    func present(using presenter: ViewControllerNavigationType) {
        let navigation = navigationService
        let errorPresenter = ProxyErrorPresenter(self.errorPresenter)

        let onAddCallback: ((@escaping (Bool) -> Void) -> Void) = { completion in
            let modal = ModalPresenter(parent: presenter)
            let stack = NavigationPresenter(
                parent: modal,
                navigationController: UINavigationController()
            )
            let sequence = ConditionPresenter(
                parent: stack,
                onPresent: { vc in modal.present(stack.navigationController); stack.present(vc) },
                onDismiss: { modal.dismiss(); stack.dismiss() }
            )

            let payload = CarAddRoutePayload { isSuccess in
                sequence.dismiss()
                completion(isSuccess)
            }
            
            let location = Navigation.Route.carAdd(payload).asLocation()
            navigation.navigate(to: location, using: sequence)
        }

        let onSelectCallback: ((CarType) -> Void) = { car in
            let payload = CarDetailsRoutePayload(identity: car.asIdentityModel())
            let location = Navigation.Route.carDetails(payload).asLocation()
            navigation.navigate(to: location, using: presenter)
        }

        let viewController = CarsListViewController(
            service: listService,
            errorPresenter: errorPresenter,
            onAddCallback: onAddCallback,
            onSelectCallback: onSelectCallback
        )

        if errorPresenter.proxy == nil {
            errorPresenter.proxy = RetryErrorPresenter.create(using: viewController)
        }

        viewController.title = NSLocalizedString("List", comment: "List of cars title")
        
        presenter.present(viewController)
    }
    
}
