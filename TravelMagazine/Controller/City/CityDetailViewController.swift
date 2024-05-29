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
        setupNavi()
        configureUI()
    }
    
    func configureUI() {
        titleLabel.text = "관광지 화면"
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    }
    
    func setupNavi() {
        self.setupNavi(title: "관광지 화면")
        
        navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
