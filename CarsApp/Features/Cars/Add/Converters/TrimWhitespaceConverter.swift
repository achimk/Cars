//
//  TrimWhitespaceConverter.swift
//  CarsApp
//
//  Created by Joachim Kret on 31/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

final class TrimWhitespaceConverter: Reader<String?, String> {

    convenience init() {
        self.init { (input) -> String in
            guard let input = input else { return "" }
            return input.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
