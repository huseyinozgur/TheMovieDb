//
//  EndpointItem.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 13.02.2021.
//

import Foundation
import Alamofire

enum EndpointItem{
    case movieNowPlaying
    case movieUpcoming
    case searchMovie(_:String)
    case movieDetail(_:String)
    case movieSimilar(_:String)
}

//https://api.themoviedb.org/3/movie/now_playing?api_key=8ceeef7cc0fa1de181f4bdb21a1bb5f6
extension EndpointItem : EndPointType{
    
    var baseUrl: String {
        switch APIManager.networkEnviroment {
        case .dev:
            return Constants.urlDev
        case .production:
            return Constants.urlProduction
        case .stage:
            return Constants.urlKeyStage
        }
    }
    
    var path: String {
        switch self{
        case .movieNowPlaying:
            return "movie/now_playing"
        case .movieUpcoming:
            return "movie/upcoming"
        case .searchMovie(let query):
            let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            return "search/movie\(self.apiKey)\(self.query)\(escapedQuery)"
        case .movieDetail(let id):
            return "movie/\(id)"
        case .movieSimilar(let id):
            return "movie/\(id)/similar"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        /*
         case .searchMovie(let query)
            return .post
         **/
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest",
                    "x-access-token": "someToken"]

        }
    }
    
    var url: URL {
        switch self {
        case .searchMovie(_):
            return URL(string: self.baseUrl + self.version + self.path)!
        default:
            return URL(string: self.baseUrl + self.version + self.path + self.apiKey)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var version: String {
        return "3/"
    }
    
    var apiKey: String {
        var key: String
        switch APIManager.networkEnviroment {
        case .dev:
            key = Constants.apiKeyDev
            break
        case .production:
            key = Constants.apiKeyProduction
            break
        case .stage:
            key = Constants.apiKeyStage
            break
        }
        return "?api_key=\(key)"
    }
    
    var query: String {
        return "&query="
    }
}
