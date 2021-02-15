//
//  UpcomingTableViewCell.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 14.02.2021.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var lblCellTitle: UILabel!
    @IBOutlet weak var lblCellDesc: UILabel!
    @IBOutlet weak var lblMoviewDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setProductData(movie:Movie)
    {
        
        self.lblCellTitle.text = movie.title
        self.lblCellDesc.text = movie.overview
        self.lblMoviewDate.text = movie.releaseDate
        //self.imageViewCell.kf.setImage(with: URL(string: movie.posterPath ?? ""))
        ImageViewHelper.shared.downloadImage(with: Constants.imageBaseUrl + (movie.posterPath ?? "")) { (image) in
            self.imageViewCell.image = image
        }
    }

}
