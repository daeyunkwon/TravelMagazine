//
//  CityDetailViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit

class CityDetailViewController: UIViewController {
    
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
        navigationItem.title = "관광지 화면"
        
        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
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
        titleLabel.text = "관광지 화면"
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    }
    
    @objc func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

}
