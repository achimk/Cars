//
//  CarsListViewController.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import RxSwift
import RxCocoa

final class CarsListViewController: UITableViewController {

    private let errorPresenter: ErrorPresenterType
    private let viewModel: CarsListViewModelType
    private let bag = DisposeBag()
    private let onAddCallback: ((@escaping (Bool) -> Void) -> Void)?
    private let onSelectCallback: ((CarType) -> Void)?

    private var items: Array<CarsListItemPresentable> = []
    private var appearsFirstTime = true

    init(service: CarsListServiceType,
         errorPresenter: ErrorPresenterType,
         onAddCallback: ((@escaping (Bool) -> Void) -> Void)? = nil,
         onSelectCallback: ((CarType) -> Void)? = nil) {

        self.viewModel = CarsListViewModel(service: service)
        self.errorPresenter = errorPresenter
        self.onAddCallback = onAddCallback
        self.onSelectCallback = onSelectCallback
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
        configureErrorPresenter()
        configureAddButtonIfNeeded()
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

    func addAction() {
        let completion: ((Bool) -> Void) = { [weak self] isSuccess in
            if isSuccess {
                self?.refreshAction()
            }
        }

        onAddCallback?(completion)
    }

    private func configureTableView() {
        tableView.register(cellType: CarsListTableViewCell.self)
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

    private func configureAddButtonIfNeeded() {
        guard onAddCallback != nil else { return }

        let sel = #selector(CarsListViewController.addAction)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: sel)
        navigationItem.rightBarButtonItem = add
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

    private func reloadData(with items: Array<CarsListItemPresentable>) {
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
        if !isLoading {
            refreshControl?.endRefreshing()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectCallback?(items[indexPath.item].asCar())
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarsListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(using: items[indexPath.item])
        return cell
    }
}
