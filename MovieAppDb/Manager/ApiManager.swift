//
//  ApiManager.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import Foundation

final class ApiManager {
    static let shared = ApiManager.init()
    private init(){}
    let apiKey: String = "11459cff1c1ce00e3202addab99f3a91"
    let imageBaseUrl: String = "https://image.tmdb.org/t/p/w500"
}
