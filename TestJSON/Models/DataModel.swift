//
//  DataModel.swift
//  TestJSON
//
//  Created by Apple on 29.06.2021.
//

import Foundation

// MARK: - Input
struct Input: Codable {
    let data: [MainData]
    let view: [String]
}

// MARK: - MainData
struct MainData: Codable {
    let name: String
    let data: SupportingData
}

// MARK: - SupportingData
struct SupportingData: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}
