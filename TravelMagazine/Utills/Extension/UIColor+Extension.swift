//
//  UIColor+Extension.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/27/24.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func customPink() -> UIColor {
        return UIColor(red: 0.96, green: 0.46, blue: 0.56, alpha: 1.00)
    }
}
