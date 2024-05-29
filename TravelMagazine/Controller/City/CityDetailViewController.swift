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
        titleLabel.text = "관광지 화면"
        titleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    

}
