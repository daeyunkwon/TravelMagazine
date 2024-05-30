//
//  MagazineTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/24/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var magazine: Magazine? {
        didSet {
            guard let magazine = magazine else {return}
            
            mainImageView.setImageToURL(url: magazine.photo_image)
            
            titleLabel.text = magazine.title
            subTitleLabel.text = magazine.subtitle
            dateLabel.text = magazine.dateString
        }
    }
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        dateLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        mainImageView.layer.cornerRadius = 10
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.backgroundColor = .systemGray5
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subTitleLabel.textColor = .systemGray
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        dateLabel.textAlignment = .right
    }
}
