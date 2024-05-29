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
        setupNavi()
        configureUI()
    }
    
    func configureUI() {
        titleLabel.text = "광고 화면"
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    }
    
    func setupNavi() {
        self.setupNavi(title: "광고 화면")
        
        navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }
    
    
    
    
    
}
