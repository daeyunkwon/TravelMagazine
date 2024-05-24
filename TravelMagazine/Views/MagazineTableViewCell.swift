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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        mainImageView.layer.cornerRadius = 10
        
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.numberOfLines = 0
        
        subTitleLabel.textColor = .systemGray5
        
        dateLabel.textColor = .systemGray5
        dateLabel.textAlignment = .right
    }

}
