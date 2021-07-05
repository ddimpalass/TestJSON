//
//  HzTableViewCellViewModel.swift
//  TestJSON
//
//  Created by Apple on 05.07.2021.
//

import Foundation

protocol HzTableViewCellViewModelProtocol {
    var text: String { get }
    
    init(data: [MainData])
}

class HzTableViewCellViewModel: HzTableViewCellViewModelProtocol {
    var text: String {
        data
            .compactMap{ $0.data.text }
            .map{ $0 + "\r\n" }
            .reduce("", +)
    }
    
    private let data: [MainData]
    
    required init(data: [MainData]) {
        self.data = data
    }
}
