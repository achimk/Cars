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
    private let viewModel: CarsListViewModelType
    private let bag = DisposeBag()
    private let onSelectCallback: ((CarType) -> Void)?
    private var items: Array<CarsListItemPresentable> = []
    private var appearsFirstTime = true

    init(service: CarsListServiceType, onSelectCallback: ((CarType) -> Void)? = nil) {
        self.viewModel = CarsListViewModel(service: service)
        self.onSelectCallback = onSelectCallback
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if appearsFirstTime {
            viewModel.inputs.fetch()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearsFirstTime = false
    }

    private func configureTableView() {
        tableView.register(cellType: CarsListTableViewCell.self)
    }

    private func configureBindings() {
        viewModel.outputs.onPresentItems.drive(onNext: { [weak self] (items) in
            self?.reloadData(with: items)
        }).addDisposableTo(bag)
    }

    private func reloadData(with items: Array<CarsListItemPresentable>) {
        self.items = items
        reloadData()
    }

    private func reloadData() {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
