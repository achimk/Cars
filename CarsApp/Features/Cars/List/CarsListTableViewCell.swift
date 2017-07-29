//
//  CarsListTableViewCell.swift
//  CarsApp
//
//  Created by Joachim Kret on 29/07/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class CarsListTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(using item: CarsListItemPresentable) {
        textLabel?.text = item.title
        detailTextLabel?.text = item.subtitle
    }
}
