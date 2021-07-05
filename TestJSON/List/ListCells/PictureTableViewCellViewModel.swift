//
//  PictureTableViewCellViewModel.swift
//  TestJSON
//
//  Created by Apple on 05.07.2021.
//

import Foundation

protocol PictureTableViewCellViewModelProtocol {
    var text: String { get }
    var imageData: Data? { get }
    
    init(data: [MainData])
}

class PictureTableViewCellViewModel: PictureTableViewCellViewModelProtocol {
    var text: String {
        data
            .compactMap{ $0.data.text }
            .reduce("", +)
    }
    
    var imageData: Data? {
        guard let url = data.first(where: { $0.name == ViewType.picture.rawValue })?.data.url,
        let imageURL = URL(string: url) else { return nil }
        let imageData = try? Data(contentsOf: imageURL)
        return imageData
    }
    
    private let data: [MainData]
    
    required init(data: [MainData]) {
        self.data = data
    }
}
