//
//  HomePageViewController.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var prefetchButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var pageNumber: Int = 1
    
    private lazy var viewModel: HomePageViewModel = HomePageViewModel.init()
    private var selectedCellType: SelectedCellType = .grid {
        didSet {
            setNavigationBar(selectedType: selectedCellType)
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        setupCollectionView()
        setUpSearchBar()
        setupGestureForSearchBar()
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.showWaitingView(message: "Loading...")
        viewModel.fetchMovieList(page: self.pageNumber)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(selectedType: selectedCellType)
    }
    
    @IBAction private func fetchMoviesAct(_ sender: Any) {
        searchBar.text = ""
        pageNumber = pageNumber + 1
        viewModel.fetchMovieList(page: pageNumber)
    }
    
    private func setNavigationBar(selectedType:SelectedCellType){
        self.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: selectedType.selectedImage, style: .plain, target: self, action: #selector(changeCellType))
    }
    
    private func setUpViewModel (){
        viewModel.delegate = self
    }
    
    @objc func changeCellType(){
        self.selectedCellType = selectedCellType == .list ? .grid : .list
    }
    
    private func setUpSearchBar(){
        searchBar.placeholder = "İstediğiniz filmi arayabilirsiniz..."
        searchBar.delegate = self
    }
    
    private func setupGestureForSearchBar(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(UINib.init(nibName: "HomePageGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomePageGridCollectionViewCell")
        collectionView.register(UINib.init(nibName: "HomePageListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomePageListCollectionViewCell")
    }
    
    private func getConstraintsBySelectedCellType() -> (height:CGFloat, width:CGFloat) {
        switch selectedCellType {
        case .grid:
            return (200,(collectionView.frame.size.width - 30)/2)
        case .list:
            return (100,(collectionView.frame.size.width - 20))
        }
    }
}


extension HomePageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMovieList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch selectedCellType {
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageListCollectionViewCell", for: indexPath) as! HomePageListCollectionViewCell
            cell.configureCell(model: viewModel.getMovieList()[indexPath.row])
            return cell
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageGridCollectionViewCell", for: indexPath) as! HomePageGridCollectionViewCell
            cell.configureCell(model: viewModel.getMovieList()[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getMovieList().count - 1  {
            prefetchButton.isHidden = false
        } else {
            prefetchButton.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: getConstraintsBySelectedCellType().width, height: getConstraintsBySelectedCellType().height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController.init(nibName: "DetailViewController", bundle: nil)
        vc.congigureController(model: viewModel.getMovieList()[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomePageViewController: HomePageProtocol {
    func filteredItems() {
        self.collectionView.reloadData()
    }
    
    func fetchedItems() {
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.hideWaitingView()
        self.collectionView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        showBasicAlert(title: "Uyarı", description: message,customAction: nil)
        self.collectionView.reloadData()
    }
}

extension HomePageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMoviesByName(searchString: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}


private enum SelectedCellType {
    case grid
    case list
    
    var selectedImage : UIImage {
        switch self {
        case .grid:
            return UIImage.init(systemName: "grid") ?? UIImage()
        case .list:
            return UIImage.init(systemName: "list.bullet") ?? UIImage()
        }
    }
}
