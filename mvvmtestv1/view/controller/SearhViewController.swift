//
//  SearhViewController.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 14.02.2021.
//

import UIKit

class SearhViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var searchData:[Movie] = [];
    var timer:Timer?

    let viewModel = SearhViewModel(api: APIManager.shared())
    var selectedMovieId:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = searchData[indexPath.row].title
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        if searchText.isEmpty {
            return
        }
        
        if searchText.count > 2 {
            timer = Timer.scheduledTimer(timeInterval: 0.5,
                                       target: self,
                                       selector: #selector(movieSearchRequest(timer:)),
                                       userInfo: searchText,
                                       repeats: false)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    
        self.selectedMovieId = String(self.searchData[indexPath.row].id!)
        self.performSegue(withIdentifier: "SearchToMovieDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SearchToMovieDetail"){
                let displayVC = segue.destination as! MovieDetailViewController
            displayVC.movieId = self.selectedMovieId
        }
    }
    @objc func movieSearchRequest(timer: Timer) {
        var searchText = timer.userInfo as! String
        searchText = searchText.replacingOccurrences(of: " ", with: "%")
        self.viewModel.searchMovie(searchText) {
            (searh:MovieResponse?, alert:AlertMessage?) in
            //self.searching = true
            self.searchData = searh?.results ?? []
            self.tableView.reloadData()
        }
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
