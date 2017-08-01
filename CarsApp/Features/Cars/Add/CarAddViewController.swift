//
//  CarAddViewController.swift
//  CarsApp
//
//  Created by Joachim Kret on 30/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class CarAddViewController: UITableViewController {

    private let errorPresenter: ErrorPresenterType
    private let viewModel: CarAddViewModelType
    private let bag = DisposeBag()

    private var buttonDone: UIBarButtonItem?
    private var buttonCancel: UIBarButtonItem?

    init(service: CarAddServiceType,
         errorPresenter: ErrorPresenterType) {
        
        let validators = CarInputValidatorsFactory()
        let converter = CarInputWhitespaceTrimmer.create()
        let specs = CarAddViewModelSpecs(shouldValidateFormBeforeSave: true)

        self.viewModel = CarAddViewModel(
            service: service,
            validators: validators,
            converter: converter,
            specs: specs
        )

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
        configureNavigationButtons()
        configureBindings()
    }

    func saveAction() {
        viewModel.inputs.save()
    }

    func cancelAction() {
        print("-> cancel")
    }

    private func configureTableView() {
        tableView.register(cellType: CarInputTableViewCell.self)
    }

    private func configureNavigationButtons() {
        configureCancelButton()
        configureDoneButton()
    }

    private func configureCancelButton() {
        let cancelSel = #selector(CarAddViewController.cancelAction)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: cancelSel)
        cancel.isEnabled = true
        navigationItem.leftBarButtonItem = cancel
        self.buttonCancel = cancel
    }

    private func configureDoneButton() {
        let doneSel = #selector(CarAddViewController.saveAction)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: doneSel)
        done.isEnabled = false
        navigationItem.rightBarButtonItem = done
        self.buttonDone = done
    }

    private func configureBindings() {
        viewModel.outputs.onFormEnabled.drive(onNext: { [weak self] (isEnabled) in
            self?.updateFormEnabled(isEnabled)
        }).addDisposableTo(bag)

        viewModel.outputs.onSaveResult.drive(onNext: { [weak self] (result) in
            switch result {
            case .success:
                self?.presentSaveSuccess()
            case .failure(let error):
                self?.presentSaveFailure(error)
            }
        }).addDisposableTo(bag)
    }

    private func updateFormEnabled(_ isEnabled: Bool) {
        buttonDone?.isEnabled = isEnabled
    }

    private func presentSaveSuccess() {
        print("->>> Save Success!")
    }

    private func presentSaveFailure(_ error: CarSaveError) {
        errorPresenter.present(with: error)
    }

    private func reloadData() {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.currentInputs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarInputTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModel.outputs.currentInputs[indexPath.item])
        return cell
    }
}
