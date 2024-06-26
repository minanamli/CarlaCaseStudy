//
//  RoverDetailCell.swift
//  CarlaCase
//
//  Created by Mina Namlı on 26.06.2024.
//

import UIKit

class RoverDetailCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var roverImg: UIImageView!
    
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    var selectedIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureElements()
    }
    
    func configureElements(){
        backView.setView(backgroundColor: .white, cornerRadius: 8)
        backView.clipsToBounds = true
        
        roverImg.layer.cornerRadius = 8
        IDLabel.setLbl(text: "", textColor: AppStyle.color(for: .red592626), textAlignment: .left, font: AppStyle.interSemiBold, fontsize: 14)
        nameLbl.setLbl(text: "", textColor: AppStyle.color(for: .gray525266), textAlignment: .left, font: AppStyle.interSemiBold, fontsize: 14)
        nameLbl.numberOfLines = 0
        dateLbl.setLbl(text: "", textColor: AppStyle.color(for: .gray696984), textAlignment: .left, font: AppStyle.interRegular, fontsize: 14)
    }
    
    func setupCell(roverDet: LatestPhoto,index: Int){
        self.selectedIndex = index
        
        IDLabel.text = "ID: \(roverDet.id)"
        nameLbl.text = roverDet.camera.fullName
        dateLbl.text = roverDet.rover.maxDate
        
        
        if let url = URL(string: roverDet.imgSrc) {
            ImageDownloader.shared.downloadImage(from: url) { [weak self] image in
                self?.roverImg.image = image
            }
            
        }
    }
    
}
