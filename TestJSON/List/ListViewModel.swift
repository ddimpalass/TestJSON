//
//  ListViewModel.swift
//  TestJSON
//
//  Created by Дмитрий on 30.06.2021.
//

import Foundation

protocol ListViewModelProtocol: AnyObject {
    var numberOfSections: Int { get }
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRowsInSection(section: Int) -> Int
    func titleForHeaderInSection(section: Int) -> String
    func textForCell(at indexPath: IndexPath) -> String
    func imageDataForCell(at indexPath: IndexPath) -> Data?
    func didSelectRow(at indexPath: IndexPath)
}

enum ViewType: String {
    case hz = "hz"
    case picture = "picture"
    case selector = "selector"
}

class ListViewModel: ListViewModelProtocol {
    var numberOfSections: Int {
        input?.view.count ?? 1
    }
    
    private var input: Input?
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.fetchDatafromNetwork { [weak self] input in
            guard let self = self,
                  let input = input else { return }
            self.input = input
            completion()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        var numberOfRowsInSection = 1
        if input?.view[section] == ViewType.selector.rawValue {
            numberOfRowsInSection = input?.data.first{ $0.name == ViewType.selector.rawValue }?.data.variants?.count ?? 1
        }
        return numberOfRowsInSection
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        var titleForHeaderInSection = ""
        switch input?.view[section] {
        case ViewType.hz.rawValue:
            titleForHeaderInSection = "Блок текста"
        case ViewType.picture.rawValue:
            titleForHeaderInSection = "Картинка"
        case ViewType.selector.rawValue:
            titleForHeaderInSection = "Варианты"
        case .none:
            titleForHeaderInSection = ""
        case .some(_):
            titleForHeaderInSection = ""
        }
        return titleForHeaderInSection
    }
    
    func textForCell(at indexPath: IndexPath) -> String {
        var text = ""
        switch input?.view[indexPath.section] {
        case ViewType.hz.rawValue:
            text = input?.data.first{ $0.name == ViewType.hz.rawValue }?.data.text ?? ""
        case ViewType.selector.rawValue:
            text = input?.data.first{ $0.name == ViewType.selector.rawValue }?.data.variants?[indexPath.row].text ?? ""
        case ViewType.picture.rawValue:
            text = input?.data.first{ $0.name == ViewType.picture.rawValue }?.data.text ?? ""
        case .none:
            text = ""
        case .some(_):
            text = ""
        }
        return text
    }
    
    func imageDataForCell(at indexPath: IndexPath) -> Data? {
        var imageData: Data?
        if input?.view[indexPath.section] == ViewType.picture.rawValue {
            guard let url = input?.data.first(where: { $0.name == ViewType.picture.rawValue })?.data.url,
                  let imageURL = URL(string: url) else { return nil }
            imageData = try? Data(contentsOf: imageURL)
        }
        return imageData
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch input?.view[indexPath.section] {
        case ViewType.hz.rawValue:
            AlertManager.showOkAlert(message: ViewType.hz.rawValue)
        case ViewType.picture.rawValue:
            AlertManager.showOkAlert(message: ViewType.picture.rawValue)
        case ViewType.selector.rawValue:
            let id = input?.data.first{ $0.name == ViewType.selector.rawValue }?.data.variants?[indexPath.row].id
            AlertManager.showOkAlert(message: "\(ViewType.selector.rawValue) with id: \(id ?? 0)")
        case .none:
            break
        case .some(_):
            break
        }
    }
}


