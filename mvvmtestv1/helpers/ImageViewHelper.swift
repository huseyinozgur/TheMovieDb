//
//  ImageViewHelper.swift
//  mvvmtestv1
//
//  Created by Hüseyin Özgür on 14.02.2021.
//

import UIKit
import Kingfisher

class ImageViewHelper {
  
  static let shared = ImageViewHelper()
  
  func downloadImage(with urlString : String , imageCompletionHandler: @escaping (UIImage?) -> Void) {
    guard let url = URL.init(string: urlString) else {
      return  imageCompletionHandler(nil)
    }
    let resource = ImageResource(downloadURL: url)
    
    KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
      switch result {
      case .success(let value):
        imageCompletionHandler(value.image)
      case .failure:
        imageCompletionHandler(nil)
      }
    }
  }
}
