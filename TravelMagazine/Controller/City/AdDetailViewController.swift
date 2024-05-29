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
        titleLabel.text = "광고 화면"
        titleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    
    
    
    
}
