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
    func view(at indexPath: IndexPath) -> String
    func titleForHeaderInSection(section: Int) -> String
    func getMainData(at indexPath: IndexPath) -> [MainData]
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
            self.input?.view = Example.view
            self.input?.data.append(Example.firstExampleHZ)
            self.input?.data.append(Example.secondExampleHZ)
            completion()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        let numberOfRowsInSection = 1
        return numberOfRowsInSection
    }
    
    func view(at indexPath: IndexPath) -> String {
        var view = ""
        switch input?.view[indexPath.section] {
        case ViewType.hz.rawValue:
            view = ViewType.hz.rawValue
        case ViewType.picture.rawValue:
            view = ViewType.picture.rawValue
        case ViewType.selector.rawValue:
            view = ViewType.selector.rawValue
        case .none:
            view = ""
        case .some(_):
            view = ""
        }
        return view
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
    
    func getMainData(at indexPath: IndexPath) -> [MainData] {
        var mainData: [MainData] = []
        switch input?.view[indexPath.section] {
        case ViewType.hz.rawValue:
            mainData = input?.data.filter{ $0.name == ViewType.hz.rawValue} ?? []
        case ViewType.picture.rawValue:
            mainData = input?.data.filter{ $0.name == ViewType.picture.rawValue} ?? []
        case ViewType.selector.rawValue:
            mainData = input?.data.filter{ $0.name == ViewType.selector.rawValue} ?? []
        case .none:
            mainData = []
        case .some(_):
            mainData = []
        }
        return mainData
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch input?.view[indexPath.section] {
        case ViewType.hz.rawValue:
            AlertManager.showOkAlert(message: ViewType.hz.rawValue)
        case ViewType.picture.rawValue:
            AlertManager.showOkAlert(message: ViewType.picture.rawValue)
        case .none:
            break
        case .some(_):
            break
        }
    }
}

struct Example {
    static let view = ["picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "hz", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "hz", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "hz", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "picture", "hz", "selector", "selector", "selector", "hz", "picture"]
    static let firstExampleHZ = MainData(name: "hz", data: SupportingData(text: "Первый некоторый текст", url: nil, selectedId: nil, variants: nil))
    static let secondExampleHZ = MainData(name: "hz", data: SupportingData(text: "Второй некоторый текст", url: nil, selectedId: nil, variants: nil))
}


