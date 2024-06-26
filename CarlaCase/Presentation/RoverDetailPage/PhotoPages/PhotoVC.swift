//
//  PhotoVC.swift
//  CarlaCase
//
//  Created by Mina Namlı on 26.06.2024.
//

import UIKit

protocol PhotoVCDelegate {
    func imgTapped()
}

class PhotoVC: UIViewController {

    var imgUrl: String?
    var index: Int?
    var isFullScreen = false
    private let imgView = UIImageView()

    var delegate: PhotoVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        view.backgroundColor = .black.withAlphaComponent(0.2)
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
        
        if !isFullScreen {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            imgView.isUserInteractionEnabled = true
            imgView.addGestureRecognizer(tapGesture)
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

    @objc func imageTapped() {
        delegate?.imgTapped()
    }
}
