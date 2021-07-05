//
//  HzTableViewCell.swift
//  TestJSON
//
//  Created by Apple on 05.07.2021.
//

import UIKit

class HzTableViewCell: UITableViewCell {

    var viewModel: HzTableViewCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = String(viewModel.text.dropLast())
            contentConfiguration = content
        }
    }
}
