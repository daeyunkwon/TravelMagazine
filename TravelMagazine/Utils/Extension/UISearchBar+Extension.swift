//
//  UISearchBar+Extension.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/2/24.
//

import UIKit

extension UISearchBar {
    func setupSearchBar(placeholder: String) {
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.placeholder = placeholder
    }
}
