//
//  UIImageView+Extension.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/28/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageToURL(url: String) {
        guard let url = URL(string: url) else {return}
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
    }
}
