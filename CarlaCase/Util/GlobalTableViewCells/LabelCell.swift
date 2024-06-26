//
//  LabelCell.swift
//  CarlaCase
//
//  Created by Mina Namlı on 26.06.2024.
//

import UIKit

class LabelCell: UITableViewCell {

    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureElements()
    }

    func configureElements() {
        secondLbl.isHidden = true
    }
    
    func setupCell(firstText: String, secondText: String? = nil, firstAlignment: NSTextAlignment, secondAlignment: NSTextAlignment? = nil, firstTextColor: UIColor, secondTextColor: UIColor? = nil, firstFont: UIFont, secondFont: UIFont? = nil, firstFontsize: Int, secondFontsize: Int? = nil) {
        
        firstLbl.setLbl(text: firstText, textColor: firstTextColor, textAlignment: firstAlignment, font: firstFont, fontsize: firstFontsize)
        
        if secondText != nil, secondAlignment != nil, secondTextColor != nil, secondFont != nil, secondFontsize != nil {
            secondLbl.isHidden = false
            secondLbl.setLbl(text: secondText ?? "", textColor: secondTextColor ?? AppStyle.color(for: .gray525266), textAlignment: secondAlignment ?? .left, font: secondFont ?? AppStyle.interMedium, fontsize: secondFontsize ?? 12)
        } else {
            secondLbl.isHidden = true
        }
        
    }
    
}
