//
//  HomePageListCollectionViewCell.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import UIKit

protocol HomePageCollectionViewCellDelegate: AnyObject {
    func getSelectedModel(model:Result)
}

final class HomePageListCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    
    
    private var model: Result?
    func configureCell(model:Result) {
        self.model = model
        self.movieTitleLabel.text = model.originalTitle
        movieImageView.getImageFromUrl(imagePath: model.posterPath)
    }
}
