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
}
