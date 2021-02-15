//
//  APIManager.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 13.02.2021.
//

import Alamofire

class APIManager {
    private let sessionManager: SessionManager
    static let networkEnviroment: NetworkEnvironment = .dev
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: SessionManager())
        return apiManager
    }()

    class func shared() -> APIManager {
        return sharedApiManager
    }
            
    private init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    
    func call<T>(type : EndPointType, params: Parameters? = nil,handler: @escaping(T?, _ error: AlertMessage?)->())where T: Codable {

        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { res in
                switch res.result{
                case .success(_):
                    
                    if let jsonData = res.data {
                        let result = try! JSONDecoder().decode(T.self, from:jsonData)
                        handler(result,nil)
                    }
                    break
                case .failure(_):
                    handler(nil,self.parseApiError(data: res.data))
                    break
                }
            }
    }
    
    private func parseApiError(data: Data?) -> AlertMessage {
            let decoder = JSONDecoder()
            if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
                return AlertMessage(title: Constants.defaultAlertTitle, body:error.status_message)
            }
        return AlertMessage(title: Constants.defaultAlertTitle, body: Constants.genericErrorMessage)
        }

}
