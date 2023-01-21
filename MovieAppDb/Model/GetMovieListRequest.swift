//
//  GetMovieListRequest.swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import Foundation
 
struct GetMovieListRequest: BaseRequestProtocol{
    var apiParams: [String : String]?    
    var httpMethod: HttpMethod
    var page: Int
    var apiPathExtension: String?
    
     init(page:Int){
        self.page = page
        self.apiParams = [
            "api_key": ApiManager.shared.apiKey,
            "language": "en-us",
            "page":"\(page)"
        ]
        self.httpMethod = .get
    }
}
