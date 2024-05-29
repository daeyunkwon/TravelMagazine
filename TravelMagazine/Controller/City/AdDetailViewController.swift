//
//  AdDetailViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        configureNavi()
        configureUILabel()
    }
    
    func configureNavi() {
        navigationItem.title = "광고 화면"
        
        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        
        let appearance = UINavigationBarAppearance()
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label,
        ]
        
        appearance.backgroundColor = .whiteToDark
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func configureUILabel() {
        titleLabel.text = "광고 화면"
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    }
    
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }
    
    
    
    
    
}
