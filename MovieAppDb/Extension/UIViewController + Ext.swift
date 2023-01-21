//
//  UIViewController + Ext.swift
//  MovieAppDb
//
//  Created by Sait Cihaner on 21.01.2023.
//

import UIKit

extension UIViewController {
    func showBasicAlert(title:String,description:String,customAction: (() -> ())?){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "TAMAM", style: .default, handler: { _ in
            customAction?()
        }))
        self.present(alert, animated: true)
    }
}
