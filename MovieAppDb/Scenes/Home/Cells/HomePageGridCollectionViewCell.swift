//
//  HomePageGridCollectionViewCell.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import UIKit

final class HomePageGridCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageOfMovieView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    
    
    private var model: Result?
    func configureCell(model:Result) {
        self.model = model
        self.movieNameLabel.text = model.originalTitle
        imageOfMovieView.getImageFromUrl(imagePath: model.posterPath)
    }
}
