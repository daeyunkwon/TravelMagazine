//
//  MagazineTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/24/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var magazine: Magazine? {
        didSet {
            guard let magazine = magazine else {return}
            
            mainImageView.image = UIImage(systemName: "star")
            titleLabel.text = magazine.title
            subTitleLabel.text = magazine.subtitle
            dateLabel.text = magazine.date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        mainImageView.layer.cornerRadius = 10
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subTitleLabel.textColor = .systemGray
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        dateLabel.textAlignment = .right
    }

}
