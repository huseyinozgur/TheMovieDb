//
//  ViewController.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 9.02.2021.
//

import UIKit
import Alamofire
import FSPagerView

class ViewController: UIViewController, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,FSPagerViewDelegate,FSPagerViewDataSource {
    
    
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var fsPagerView: FSPagerView!  {
        didSet {
            self.fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.fsPagerView.transformer = FSPagerViewTransformer(type: .linear)
            self.fsPagerView.itemSize = CGSize(width: 374, height: 225)
            self.fsPagerView.isInfinite = true
            self.fsPagerView.contentMode = .scaleAspectFit
            self.fsPagerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.fsPagerView.automaticSlidingInterval = 3.0
            self.movieNowPlaying()
        }
    }
    
    let viewModel = HomePageViewModel(api: APIManager.shared())

    var sliders:[SlideBanner] = [];
    var upcoming:[Movie] = [];
    var nowplayingData:[Movie] = [];
    
    var selectedMovieId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie"
        upcomingTableView.dataSource=self
        fsPagerView.dataSource=self
        fsPagerView.delegate=self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(menuBtnPressed))
        self.movieUpComing()
        
    }
    @objc func menuBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "SearchView", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func movieNowPlaying() {
        viewModel.fetchMovieNowPlaying {
            (handler: MovieResponse?, error : AlertMessage?) in
            self.nowplayingData = handler?.results ?? []
            self.fsPagerView.reloadData()
        }
    }
    
    func movieUpComing() {
        viewModel.fetchMovieUpcoming()
        
        viewModel.didFinishFetch = {
            self.upcoming = self.viewModel.upcomingData?.results ?? []
            self.upcomingTableView.reloadData()
        }
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        
        return self.nowplayingData.count
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {

        self.selectedMovieId = String(self.nowplayingData[index].id!)
        self.performSegue(withIdentifier: "HomeToMovieDetail", sender: self)

    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        ImageViewHelper.shared.downloadImage(with: Constants.imageBaseUrl + ( self.nowplayingData[index].posterPath ?? "")) { (image) in
            cell.imageView!.image = image
        }
        
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel!.text = self.nowplayingData[index].title ?? ""
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcoming.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as! UpcomingTableViewCell
        //let cell = self.upcomingTableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as! UpcomingTableViewCell
        
        let cell = Bundle.main.loadNibNamed("UpcomingTableViewCell", owner: self, options: nil)?.first as! UpcomingTableViewCell
        
        cell.setProductData(movie: self.upcoming[indexPath.row])
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    
        self.selectedMovieId = String(self.upcoming[indexPath.row].id!)
        self.performSegue(withIdentifier: "HomeToMovieDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "HomeToMovieDetail"){
            let displayVC = segue.destination as! MovieDetailViewController
            displayVC.movieId = self.selectedMovieId
        }else if(segue.identifier == "SearchView"){
            segue.destination as! SearhViewController
        }
    }
}
