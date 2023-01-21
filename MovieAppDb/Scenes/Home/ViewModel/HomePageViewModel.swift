//
//  HomePageViewModel.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import Foundation

protocol HomePageProtocol : AnyObject {
    func fetchedItems()
    func showErrorMessage(message:String)
    func filteredItems()
}

final class HomePageViewModel {
    private var allMovieList: [Result] = []
    private var filteredMovieList: [Result] = []
    weak var delegate: HomePageProtocol?
    
     func fetchMovieList(page:Int){
        Network.getApiRequest(request: GetMovieListRequest.init(page: page), response: TopMovieResponse.self) { [weak self] response in
            guard let self = self else {return}
            response.results?.forEach({ item in
                self.allMovieList.append(item)
            })
            self.filteredMovieList = self.allMovieList
            self.delegate?.fetchedItems()
        } errorHandler: { [weak self] err in
            guard let self = self else {return}
            self.delegate?.showErrorMessage(message: err)
        }
    }
    
    func filterMoviesByName(searchString: String) {
        filteredMovieList.removeAll()
        if searchString.count < 3 {
        filteredMovieList = allMovieList
            delegate?.filteredItems()
        } else {
            let temporaryArray: [Result] = allMovieList
            temporaryArray.forEach { item in
                let model = item.title?.replacingOccurrences(of: " ", with: "")
                if model?.contains(searchString) ?? false || model?.contains(searchString.uppercased()) ?? false || model?.contains(searchString.lowercased()) ?? false{
                    filteredMovieList.append(item)
                }
            }
            if filteredMovieList.isEmpty {
                delegate?.showErrorMessage(message: "İstediğiniz keyword için film bulunamadı..")
            } else {
                delegate?.filteredItems()
            }
        }
    }
    
    func getMovieList() -> [Result] {
        return self.filteredMovieList
    }
    
}

