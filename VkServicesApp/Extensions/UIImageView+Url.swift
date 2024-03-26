//
//  UIImageView+Url.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 26.03.2024.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func cacheImage(urlString: String, completion: ((Bool) -> Void)? = nil) {
    let url = URL(string: urlString)
    
    image = nil
    completion?(true)

    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
        self.image = imageFromCache
        completion?(false)
        return
    }

    URLSession.shared.dataTask(with: url!) {
        data, response, error in
          if let response = data {
              DispatchQueue.main.async {
                  let imageToCache = UIImage(data: data!)
                  imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                  self.image = imageToCache
                  completion?(false)
              }
          }
     }.resume()
  }
}
