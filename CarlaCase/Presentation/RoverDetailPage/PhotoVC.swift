//
//  PhotoVC.swift
//  CarlaCase
//
//  Created by Mina Namlı on 26.06.2024.
//

import UIKit

class PhotoVC: UIViewController {
    
    var imgUrl: String?
    var index: Int?
    
    private let imgView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        view.addSubview(imgView)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        imgView.contentMode = .scaleAspectFill
        
        if let imageUrl = imgUrl, let url = URL(string: imageUrl) {
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.imgView.image = image
            }
        }.resume()
    }
}

