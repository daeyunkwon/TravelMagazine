//
//  AdDetailViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit

class AdDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    
    var travel: Travel?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupNavi()
        configureUI()
    }
    
    //MARK: - Configurations
    
    func setupData() {
        guard let title = travel?.title else {return}
        titleLabel.text = title
    }
    
    func configureUI() {
        titleLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    func setupNavi() {
        self.setupNavi(title: "광고", isShowSeparator: true)
        
        navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    //MARK: - Functions
    
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }
}
