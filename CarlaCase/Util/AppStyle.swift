//
//  AppStyle.swift
//  CarlaCase
//
//  Created by Mina Namlı on 25.06.2024.
//

import Foundation
import UIKit

enum ColorCode: String {
    case grayDFDFE7 = "DFDFE7"
    case red592626 = "592626"
    case gray525266 = "525266"
    case pinkFDE5E5 = "FDE5E5"
    case redC1272D = "C1272D"
    case greenD5F8E8 = "D5F8E8"
    case green3EAA77 = "3EAA77"
    case yellowFFD159 = "FFD159"
    case gray696984 = "696984"
    case gray302F2C = "302F2C"

    var color: UIColor {
        return UIColor(hex: self.rawValue)
    }
}

enum FontWeight: String {
    case Bold
    case Regular
    case SemiBold
    case Medium
}

enum FontName: String {
    case inter = "Inter"
}

struct AppStyle {
    static func color(for code: ColorCode) -> UIColor {
        return code.color
    }
    
    static func font(name: FontName, weight: FontWeight, size: CGFloat = 10) -> UIFont {
        let fontName = "\(name.rawValue)-\(weight.rawValue.capitalized)"
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static let interBold = font(name: .inter, weight: .Bold)
    static let interSemiBold = font(name: .inter, weight: .SemiBold)
    static let interRegular = font(name: .inter, weight: .Regular)
    static let interMedium = font(name: .inter, weight: .Medium)
}

extension UIColor {
//    burada hex colori ui colora ceviriyoruz
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xff0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00ff00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000ff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
