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
    
    static func customSkyBlue() -> UIColor {
        return UIColor.rgb(red: 133, green: 186, blue: 238)
    }
    
    static func customBlue() -> UIColor {
        return UIColor.rgb(red: 46, green: 146, blue: 244)
    }
    
    static func randomColor() -> UIColor {
        var randomBackgroundColorList: [UIColor] = [
            UIColor.rgb(red: 250, green: 187, blue: 200),
            UIColor.rgb(red: 139, green: 206, blue: 228),
            UIColor.rgb(red: 249, green: 215, blue: 128),
            UIColor.rgb(red: 171, green: 182, blue: 251),
            UIColor.rgb(red: 160, green: 216, blue: 161),
        ]
        
        return randomBackgroundColorList.randomElement() ?? UIColor.rgb(red: 250, green: 187, blue: 200)
    }
}
