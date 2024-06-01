//
//  UIViewController+Extension.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit

extension UIViewController {
    func setupNavi(title: String, isShowSeparator: Bool) {
        navigationItem.title = title
        
        let appearance = UINavigationBarAppearance()
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label,
        ]
        
        appearance.backgroundColor = .whiteToDark
        
        if isShowSeparator {
            appearance.shadowColor = .systemGray3
        } else {
            appearance.shadowColor = .clear
        }
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.tintColor = .label
    }
}
