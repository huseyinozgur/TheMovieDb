//
//  EndPointType.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 13.02.2021.
//

import Alamofire

protocol EndPointType {
    var baseUrl:String {get}
    var path:String {get}
    var httpMethod:HTTPMethod {get}
    var headers:HTTPHeaders {get}
    var url:URL {get}
    var encoding:ParameterEncoding { get }
    var version:String {get}
    var apiKey:String {get}
    var query:String{get}
}
