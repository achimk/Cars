//
//  CarDetailsViewController.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class CarDetailsViewController: UITableViewController {
    private let hud = ProgressHud()
    private let errorPresenter: ErrorPresenterType
    private let viewModel: CarDetailsViewModelType
    private let bag = DisposeBag()

    private var items: Array<CarDetailsItemPresentable> = []
    private var appearsFirstTime = true

    init(identity: CarIdentityModel,
         service: CarDetailsServiceType,
         errorPresenter: ErrorPresenterType) {

        self.viewModel = CarDetailsViewModel(identity: identity, service: service)
        self.errorPresenter = errorPresenter
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("[*] \(type(of: self)): \(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureRefreshControl()
        configureBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if appearsFirstTime {
            refreshAction()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearsFirstTime = false
    }

    func refreshAction() {
        viewModel.inputs.fetch()
    }

    private func configureTableView() {
        tableView.register(cellType: CarDetailsTableViewCell.self)
        tableView.allowsSelection = false
    }

    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        let sel = #selector(CarsListViewController.refreshAction)
        refreshControl.addTarget(self, action: sel, for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
    }

    private func configureErrorPresenter() {
        errorPresenter.next = ErrorHandler { [weak self] _ in
            self?.refreshAction()
            return true
        }
    }

    private func configureBindings() {
        viewModel.outputs.onPresentResult.drive(onNext: { [weak self] (result) in
            switch result {
            case .success(let items):
                self?.reloadData(with: items)
            case .failure(let error):
                self?.presentError(error)
            }
        }).addDisposableTo(bag)

        viewModel.outputs.onLoading.drive(onNext: { [weak self] (isLoading) in
            self?.updateLoadingIndicator(isLoading)
        }).addDisposableTo(bag)
    }

    private func reloadData(with items: Array<CarDetailsItemPresentable>) {
        self.items = items
        reloadData()
    }

    private func reloadData() {
        tableView.reloadData()
    }

    private func presentError(_ error: CarsServiceError) {
        errorPresenter.present(with: error)
    }

    private func updateLoadingIndicator(_ isLoading: Bool) {
        let isRefreshing = refreshControl?.isRefreshing ?? false

        switch (isLoading, isRefreshing) {
        case (true, false):
            hud.show(in: view, animated: true)

        case (false, _):
            hud.dismiss(animated: true)
            refreshControl?.endRefreshing()

        default: break
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(using: items[indexPath.item])
        return cell
    }

}
