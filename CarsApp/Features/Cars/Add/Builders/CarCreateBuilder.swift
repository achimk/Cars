//
//  CarCreateBuilder.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

final class CarCreateBuilder: CarStepConfigurable, CarCreateBuilderType {
    private let validators: CarInputValidatorsFactoryType
    private var name: String?
    private var brand: String?
    private var model: String?
    private var year: String?

    init(validators: CarInputValidatorsFactoryType) {
        self.validators = validators
    }

    func set(name: String?) {
        self.name = name
    }

    func set(brand: String?) {
        self.brand = brand
    }

    func set(model: String?) {
        self.model = model
    }

    func set(year: String?) {
        self.year = year
    }

    func build() throws -> CarCreateModel {
        let validName = try createValid(value: name, using: validators.createNameValidator())
        let validBrand = try createValid(value: brand, using: validators.createBrandValidator())
        let validModel = try createValid(value: model, using: validators.createModelValidator())
        let validYear = try createValid(value: year, using: validators.createYearValidator())

        return CarCreateModel(
            name: validName,
            model: validModel,
            brand: validBrand,
            year: Int(validYear) // FIXME: Year should have dedicated converter!
        )
    }

    private func createValid(value: String?, using validator: CarInputValidator) throws -> String {
        let result = validator(value)

        switch result {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }

    private func createValid<O>(
        value: String?,
        preFormatter: ((String?) -> String?)? = nil,
        validator: CarInputValidator,
        postFormatter: ((String) -> O)? = nil) throws -> O {

        fatalError()
    }
}
