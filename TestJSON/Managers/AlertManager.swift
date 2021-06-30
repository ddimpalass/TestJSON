//
//  AlertManager.swift
//  TestJSON
//
//  Created by Дмитрий on 30.06.2021.
//

import UIKit

class AlertManager {
    class func showOkAlert(message: String) {
        let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        rootViewController?.present(alert, animated: true)
    }
}
