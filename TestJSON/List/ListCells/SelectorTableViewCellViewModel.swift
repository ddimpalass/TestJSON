//
//  SelectorTableViewCellViewModel.swift
//  TestJSON
//
//  Created by Apple on 05.07.2021.
//

import Foundation

import Foundation

protocol SelectorTableViewCellViewModelProtocol {
    
    var supportingData: [SupportingData] { get }
    
    init(data: [MainData])
}

class SelectorTableViewCellViewModel: SelectorTableViewCellViewModelProtocol {
    
    var supportingData: [SupportingData] {
        data.compactMap{ $0.data }
    }
    
    private let data: [MainData]
    
    required init(data: [MainData]) {
        self.data = data
    }
}
