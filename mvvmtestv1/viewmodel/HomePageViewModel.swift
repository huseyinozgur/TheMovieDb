//
//  HomePageViewModel.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 13.02.2021.
//

import Foundation

class HomePageViewModel {
    
    var sliderData: MovieResponse? {
        didSet {
            guard sliderData != nil else { return }
            self.didFinishFetch?()
        }
    }
    
    var upcomingData: MovieResponse? {
        didSet {
            guard upcomingData != nil else { return }
            self.didFinishFetch?()
        }
    }
    
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
    
    func fetchMovieNowPlaying(_ handler:@escaping(_ nowplaying: MovieResponse?, _ error: AlertMessage?)->()) {
        self.api?.call(type: EndpointItem.movieNowPlaying) {
            (nowplaying : MovieResponse?,alert:AlertMessage?) in
            if let data = nowplaying {
                self.error = nil
                self.isLoading = true
                self.sliderData = data
                handler(data,nil)
            }else {
                self.error = alert
                self.isLoading = false
                self.sliderData = nil
                handler(nil,alert)
            }
        }
    }
    
    func fetchMovieUpcoming(){
        self.api?.call(type: EndpointItem.movieUpcoming) {
            (upcoming : MovieResponse?,alert:AlertMessage?) in
            if let data = upcoming {
                self.error = nil
                self.isLoading = true
                self.upcomingData = data
            }else {
                self.error = alert
                self.isLoading = false
                self.upcomingData = nil
            }
        }
    }
}

