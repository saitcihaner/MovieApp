//
//  Api + Request .swift
//  MovieApp
//
//  Created by Sait Cihaner on 17.01.2023.
//

import Foundation
import Alamofire

final class Network {
    static func getApiRequest<T:Decodable>(request:BaseRequestProtocol,response:T.Type,successHandler:@escaping(T)->(),errorHandler:@escaping(String)->()){
        var apiHttpMethod: HTTPMethod = .get
        switch request.httpMethod {
        case .post:
            apiHttpMethod = .post
        case .delete:
            apiHttpMethod = .delete
        case .put:
            apiHttpMethod = .put
        default:
            break
        }
        AF.request(request.getApiUrl(), method: apiHttpMethod, parameters: request.apiParams).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let res):
                successHandler(res)
            case .failure(let err):
                errorHandler(err.localizedDescription)
            }
        }
    }
}
