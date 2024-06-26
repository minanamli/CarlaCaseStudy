//
//  Extensions.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import Foundation
import UIKit

enum LoadingAct {
    case start
    case stop
}

private var activityIndicator: UIActivityIndicatorView?

extension UIViewController {

//    apple'in default activityIndicator'unu kullandim. bu set fonksiyonunu çağırarak yuklenmeyi baslatip durduruyoruz.
    
    func setLoading(startOrStop: LoadingAct) {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator?.tintColor = .white
            activityIndicator?.layer.cornerRadius = 5
            activityIndicator?.center = view.center
            activityIndicator?.hidesWhenStopped = true
            if let activityIndicator = activityIndicator {
                view.addSubview(activityIndicator)
            }
        }
        
        switch startOrStop {
        case .start:
            activityIndicator?.startAnimating()
            view.layer.opacity = 0.3
        case .stop:
            activityIndicator?.stopAnimating()
            view.layer.opacity = 1
        }
    }
    
    func makeAlert(title: String, message: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        present(alert, animated: true)
    }
}

extension UIView {
    
    func setView(backgroundColor: UIColor, cornerRadius: Int, borderWidth: Int? = nil, borderColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = CGFloat(cornerRadius)
        if borderWidth != nil {
            self.layer.borderWidth = CGFloat(borderWidth ?? 0)
        }
        if borderWidth != nil {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
}

extension UILabel {
    
    func setLbl(text: String ,textColor: UIColor, textAlignment: NSTextAlignment,font: UIFont, fontsize: Int) {
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font.withSize(CGFloat(fontsize))
    }
}

extension UIImageView {
    
    func setImageView(imgName: String, tintColor: UIColor? = nil){
        if tintColor == nil {
            self.image = UIImage(named: imgName)
        } else {
            self.image = UIImage(named: imgName)?.withTintColor(tintColor!)
        }
    }
    
    func setSystemImage(imgName: String ,tintColor: UIColor) {
        self.image = UIImage(systemName: imgName)
        self.tintColor = tintColor
    }
}

class ImageDownloader {
    static let shared = ImageDownloader()
    private init() {}
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = url.absoluteString as NSString
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
