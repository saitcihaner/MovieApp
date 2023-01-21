//
//  DetailViewController.swift
//  MovieAppDb
//
//  Created by Sait Cihaner on 21.01.2023.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var averageLabel: UILabel!
    private var model : Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupGesture()
    }
    func congigureController(model:Result){
        self.model = model
    }
    private func setUpUI(){
        self.title = self.model?.originalTitle
        popularityLabel.text = "\(String(describing: self.model?.popularity ?? 0.0))"
        self.descriptionLabel.text = self.model?.overview
        self.averageLabel.text = "\(String(describing: self.model?.voteAverage ?? 0.0))"
    }
    
    private func setupGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(popController))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func popController(){
        self.navigationController?.popViewController(animated: true)
    }
}
