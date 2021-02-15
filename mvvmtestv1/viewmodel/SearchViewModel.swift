//
//  SearchViewModel.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 14.02.2021.
//

import Foundation
class SearhViewModel {
    var searchData: MovieResponse? {
        didSet {
            guard searchData != nil else { return }
            self.didFinishFetch?()
        }
    }
    
    var error: AlertMessage? {
       didSet { self.showAlertClosure?() }
    }

    var isLoading: Bool = false {
       didSet { self.updateLoadingStatus?() }
    }
    
    private var api: APIManager?
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    init(api: APIManager) {
        self.api = api
    }
    
    func searchMovie(_ searchkey:String,_ handler:@escaping(_ nowplaying: MovieResponse?, _ error: AlertMessage?)->()){
        self.api?.call(type: EndpointItem.searchMovie(searchkey)){
            (search : MovieResponse?,alert:AlertMessage?) in
            if let data = search {
                self.error = nil
                self.isLoading = true
                self.searchData = data
                handler(data,nil)
            }else {
                self.error = alert
                self.isLoading = false
                self.searchData = nil
                handler(nil,alert)
            }
        }
    }
    
}
