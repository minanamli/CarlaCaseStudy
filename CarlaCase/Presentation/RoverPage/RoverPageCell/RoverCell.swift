//
//  RoverCell.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import UIKit

protocol RoverCellDelegate {
    func roverClicked(index: Int)
    func deactive()
}

class RoverCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var roverImg: UIImageView!
    
    @IBOutlet weak var roverName: UILabel!
    
    @IBOutlet weak var landingDateLbl: UILabel!
    @IBOutlet weak var landingDate: UILabel!
    
    @IBOutlet weak var launchDateLbl: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    
    @IBOutlet weak var statuBtnView: UIView!
    @IBOutlet weak var statuBtnLbl: UILabel!
    
    @IBOutlet weak var arrowImg: UIImageView!
    
    var delegate: RoverCellDelegate?
    var selectedIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureElements()
    }
    
    func configureElements(){
        backView.setView(backgroundColor: .white, cornerRadius: 8,borderWidth: 1,borderColor: AppStyle.color(for: .grayDFDFE7))
        backView.clipsToBounds = true
        
        roverName.setLbl(text: "", textColor: AppStyle.color(for: .red592626), textAlignment: .left, font: AppStyle.interSemiBold, fontsize: 18)
        landingDateLbl.setLbl(text: Constants.AppStr.landingDate, textColor: AppStyle.color(for: .gray525266), textAlignment: .left, font: AppStyle.interRegular, fontsize: 14)
        launchDateLbl.setLbl(text: Constants.AppStr.launchDate, textColor: AppStyle.color(for: .gray525266), textAlignment: .left, font: AppStyle.interRegular, fontsize: 14)
        
        landingDate.setLbl(text: "", textColor: AppStyle.color(for: .gray525266), textAlignment: .left, font: AppStyle.interSemiBold, fontsize: 12)
        launchDate.setLbl(text: "", textColor: AppStyle.color(for: .gray525266), textAlignment: .left, font: AppStyle.interSemiBold, fontsize: 12)
        
        statuBtnView.setView(backgroundColor: AppStyle.color(for: .pinkFDE5E5), cornerRadius: 6,borderWidth: 1,borderColor: AppStyle.color(for: .redC1272D))
        statuBtnLbl.setLbl(text: "", textColor: AppStyle.color(for: .redC1272D), textAlignment: .center, font: AppStyle.interSemiBold, fontsize: 14)
        
        arrowImg.setImageView(imgName: Constants.AppIcons.arrow, tintColor: AppStyle.color(for: .red592626))
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(roverClicked))
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(gest)
    }
    
    func setupCell(rover: Rover,index: Int){
        self.selectedIndex = index
        
        self.roverName.text = rover.name
        self.launchDate.text = rover.launchDate
        self.landingDate.text = rover.landingDate
        
        if let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCgKwDlZOoAdUsqkWu1H8EATeZJmPh8Mvhqg&s") {
//            if let url = URL(string: rover.) {
            ImageDownloader.shared.downloadImage(from: url) { [weak self] image in
                self?.roverImg.image = image
            }
        }
        
        if rover.status == "complete" {
            statuBtnView.setView(backgroundColor: AppStyle.color(for: .pinkFDE5E5), cornerRadius: 6,borderWidth: 1,borderColor: AppStyle.color(for: .redC1272D))
            statuBtnLbl.setLbl(text: Constants.AppStr.deactive, textColor: AppStyle.color(for: .redC1272D), textAlignment: .center, font: AppStyle.interSemiBold, fontsize: 14)
            let gest = UITapGestureRecognizer(target: self, action: #selector(deactive))
            backView.isUserInteractionEnabled = true
            backView.addGestureRecognizer(gest)
        } else if rover.status == "active" {
            statuBtnView.setView(backgroundColor: AppStyle.color(for: .greenD5F8E8), cornerRadius: 6,borderWidth: 1,borderColor: AppStyle.color(for: .green3EAA77))
            statuBtnLbl.setLbl(text: Constants.AppStr.active, textColor: AppStyle.color(for: .green3EAA77), textAlignment: .center, font: AppStyle.interSemiBold, fontsize: 14)
            let gest = UITapGestureRecognizer(target: self, action: #selector(roverClicked))
            backView.isUserInteractionEnabled = true
            backView.addGestureRecognizer(gest)
        }
    }
    
    @objc func roverClicked(){
        delegate?.roverClicked(index: self.selectedIndex)
    }
    
    @objc func deactive(){
        delegate?.deactive()
    }
}
