//
//  CarInputTableViewCell.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class CarInputTableViewCell: UITableViewCell, NibReusable, UITextFieldDelegate {
    @IBOutlet weak var textFieldInput: UITextField?

    private var viewModel: CarInputViewModelType?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureTextField()
    }

    private func configureTextField() {
        let sel = #selector(CarInputTableViewCell.textDidChange)
        textFieldInput?.addTarget(self, action: sel, for: .editingChanged)
        textFieldInput?.delegate = self
    }

    func configure(with viewModel: CarInputViewModelType) {
        self.viewModel = viewModel

        textFieldInput?.placeholder = viewModel.outputs.currentPlaceholder
        textFieldInput?.text = viewModel.outputs.currentText
    }

    func textDidChange() {
        let text = textFieldInput?.text
        viewModel?.inputs.change(input: text)
    }

}
