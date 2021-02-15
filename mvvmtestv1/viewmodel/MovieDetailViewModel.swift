//
//  MovieDetailViewModel.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 15.02.2021.
//

import Foundation
import Alamofire
class MovieDetailViewModel{
    
    var movie: MovieDetailResponse? {
        didSet {
            guard movie != nil else { return }
            self.didFinishFetch?()
        }
    }
    var similer: MovieResponse? {
        didSet {
            guard similer != nil else { return }
            self.didFinishFetch?()
        }
    }
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    var error: AlertMessage? {
       didSet { self.showAlertClosure?() }
    }

    var isLoading: Bool = false {
       didSet { self.updateLoadingStatus?() }
    }
    
    private var api: APIManager?
    
    init(api: APIManager) {
        self.api = api
    }
    
    func getMovieDetail(_ id:String,_ handler:@escaping(_ nowplaying: MovieDetailResponse?, _ error: AlertMessage?)->()){
        self.api?.call(type: EndpointItem.movieDetail(id)){
            (movie : MovieDetailResponse?,alert:AlertMessage?) in
            if let data = movie {
                self.error = nil
                self.isLoading = true
                self.movie = data
                handler(data,nil)
            }else {
                self.error = alert
                self.isLoading = false
                self.movie = nil
                handler(nil,alert)
            }
        }
    }
    
    func fetchMovieSimiler(id:String){
        self.api?.call(type: EndpointItem.movieSimilar(id)) {
            (similer : MovieResponse?,alert:AlertMessage?) in
            if let data = similer {
                self.error = nil
                self.isLoading = true
                self.similer = data
            }else {
                self.error = alert
                self.isLoading = false
                self.similer = nil
            }
        }
    }
}
