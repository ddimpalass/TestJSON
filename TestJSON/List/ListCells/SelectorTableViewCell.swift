//
//  SelectorTableViewCell.swift
//  TestJSON
//
//  Created by Apple on 04.07.2021.
//

import UIKit

class SelectorTableViewCell: UITableViewCell {
    @IBOutlet weak var segmentedControlForSelectedId: UISegmentedControl!
    @IBOutlet weak var segmentedControlForVariants: UISegmentedControl!
    
    @IBAction func segmentedControlActionForVariants(_ sender: Any) {
        guard segmentedControlForSelectedId.selectedSegmentIndex == 0 else { return }
        switch segmentedControlForVariants.selectedSegmentIndex {
        case 0:
            AlertManager.showOkAlert(message: "\(ViewType.selector.rawValue) with id: 1")
        case 1:
            AlertManager.showOkAlert(message: "\(ViewType.selector.rawValue) with id: 2")
        case 2:
            AlertManager.showOkAlert(message: "\(ViewType.selector.rawValue) with id: 3")
        default:
            return
        }
    }
    
    var viewModel: SelectorTableViewCellViewModelProtocol! {
        didSet {
            segmentedControlForSelectedId.removeAllSegments()
            segmentedControlForVariants.removeAllSegments()
            let selectors = viewModel.supportingData
            selectors.forEach { selector in
                segmentedControlForSelectedId.insertSegment(
                    withTitle: "SelectorId \(selector.selectedId ?? 0)",
                    at: selector.selectedId ?? 0,
                    animated: true)
                selector.variants?.forEach { variant in
                    segmentedControlForVariants.insertSegment(
                        withTitle: variant.text,
                        at: variant.id,
                        animated: true)
                }
            }
        }
    }
}
