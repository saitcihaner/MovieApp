//
//  UImageView + Ext.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import UIKit
import Kingfisher

extension UIImageView{
    func getImageFromUrl(imagePath:String?) {
        guard let url = URL.init(string: ApiManager.shared.imageBaseUrl + (imagePath ?? "")) else {return}
        self.kf.setImage(with: url)
    }
}
