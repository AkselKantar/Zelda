//
// Created by Aksel Kantar on 2019-04-11.
// Copyright (c) 2019 Aksel Kantar. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .gray)
    
    func loadImage(from url: URL ) {
        image = nil
        addSpinner()
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            removeSpinner()
            image = imageFromCache
            return
        }

        task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            guard let data = data,
               let newImage = UIImage(data: data)
                    else {
                print("couldn't load image from url \(url)")
                return
            }
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.removeSpinner()
                self.image = newImage
            }
        }
        task.resume()
    }
    
    func addSpinner() {
        
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        spinner.removeFromSuperview()
    }
}
