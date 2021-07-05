//
//  ViewController.swift
//  TestJSON
//
//  Created by Apple on 29.06.2021.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: ListViewModelProtocol! {
        didSet {
            viewModel.fetchCourses {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListViewModel()
    }
}

// MARK: UITableView

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hzCell = tableView.dequeueReusableCell(withIdentifier: ViewType.hz.rawValue, for: indexPath) as? HzTableViewCell,
              let pictureCell = tableView.dequeueReusableCell(withIdentifier: ViewType.picture.rawValue, for: indexPath) as? PictureTableViewCell,
              let selectorCell = tableView.dequeueReusableCell(withIdentifier: ViewType.selector.rawValue, for: indexPath) as? SelectorTableViewCell else { return UITableViewCell() }
        switch viewModel.view(at: indexPath) {
        case ViewType.hz.rawValue:
            hzCell.viewModel = HzTableViewCellViewModel(data: viewModel.getMainData(at: indexPath))
            return hzCell
        case ViewType.picture.rawValue:
            pictureCell.viewModel = PictureTableViewCellViewModel(data: viewModel.getMainData(at: indexPath))
            return pictureCell
        case ViewType.selector.rawValue:
            selectorCell.viewModel = SelectorTableViewCellViewModel(data: viewModel.getMainData(at: indexPath))
            return selectorCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

