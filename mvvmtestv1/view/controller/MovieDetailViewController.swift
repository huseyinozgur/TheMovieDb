//
//  MovieDetailViewController.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 15.02.2021.
//

import UIKit

class MovieDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var movieId: String!
    let viewModel = MovieDetailViewModel(api: APIManager.shared())
    var imbdbUrl:URL!
    @IBOutlet weak var imdbImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelStar: UILabel!
    @IBOutlet weak var collection: UICollectionView!{
        didSet{
            movieSimiler()
        }
    }
    
    var similerMovies:[Movie] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.delegate=self
        self.collection.dataSource = self
        getMovieDetail()
        let nibCell = UINib(nibName: "SimilerCollectionViewCell", bundle: nil)
        self.collection.register(nibCell, forCellWithReuseIdentifier: "SimilerCollectionViewCell")
        self.collection.reloadData()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imdbImageView.isUserInteractionEnabled = true
        imdbImageView.addGestureRecognizer(tapGestureRecognizer)

    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        UIApplication.shared.open(imbdbUrl)
    }
    func getMovieDetail(){
        viewModel.getMovieDetail(self.movieId){
            (hander: MovieDetailResponse?,error:AlertMessage?) in
            if let data = hander {
                self.labelTitle.text = data.title
                self.labelDesc.text = data.overview
                self.labelStar.text = String(data.voteAverage ?? 0)
                ImageViewHelper.shared.downloadImage(with: Constants.imageBaseUrl + (data.posterPath ?? "")) { (image) in
                    self.imageView.image = image
                }
                if data.imdbID != nil{
                    self.imbdbUrl = URL(string: Constants.imdbUrl + "\(data.imdbID!)")
                    self.imdbImageView.isHidden=false
                }else{
                    self.imdbImageView.isHidden=true
                }
                self.title = data.title
            }
            else {
                
            }
        }
    }
    
    func movieSimiler() {
        viewModel.fetchMovieSimiler(id: movieId)
        
        viewModel.didFinishFetch = {
            self.similerMovies = self.viewModel.similer?.results ?? []
            self.collection.reloadData()
            DispatchQueue.main.async(execute: self.collection.reloadData)

        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similerMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = Bundle.main.loadNibNamed("SimilerCollectionViewCell", owner: self, options: nil)?.first as! SimilerCollectionViewCell
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "SimilerCollectionViewCell", for: indexPath) as! SimilerCollectionViewCell
        print(indexPath.row)
        cell.setData(movie: self.similerMovies[indexPath.row])
        return cell
    }
    
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.movieId = String(self.similerMovies[indexPath.row].id!)
        
        getMovieDetail()
        movieSimiler()
    }
    
}
