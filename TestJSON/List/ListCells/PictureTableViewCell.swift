//
//  PictureTableViewCell.swift
//  TestJSON
//
//  Created by Apple on 04.07.2021.
//

import UIKit

class PictureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var viewModel: PictureTableViewCellViewModelProtocol! {
        didSet {
            guard let imageData = viewModel.imageData else { return }
            cellImage.image = UIImage(data: imageData)
            label.text = viewModel.text
        }
    }
}
