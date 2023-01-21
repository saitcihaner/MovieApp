//
//  BaseRequestProtocol.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import Foundation

protocol BaseRequestProtocol {
    var apiMainPath: String {get}
    var apiParams: [String:String]? {get}
    var httpMethod: HttpMethod {get}
    var apiPathExtension: String? {get}
    func getApiUrl() -> URL
}

extension BaseRequestProtocol {
    func getApiUrl() -> URL {
        guard let url = URL.init(string: apiMainPath + (apiPathExtension ?? "")) else {return URL(fileURLWithPath: "")}
        return url
    }
    var apiMainPath: String {
        return "https://api.themoviedb.org/3/movie/top_rated"
    }
}
enum HttpMethod {
    case get
    case post
    case put
    case delete
}
