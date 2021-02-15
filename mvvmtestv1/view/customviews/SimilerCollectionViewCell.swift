//
//  SimilerCollectionViewCell.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 15.02.2021.
//

import UIKit

class SimilerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(movie:Movie){
        
        self.labelTitle.text = movie.title
        ImageViewHelper.shared.downloadImage(with: Constants.imageBaseUrl + (movie.posterPath ?? "")) { (image) in
            self.imageView.image = image
        }
    }
}
