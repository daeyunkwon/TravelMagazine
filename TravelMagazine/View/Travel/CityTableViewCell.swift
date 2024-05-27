//
//  CityTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/27/24.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var gradeLabel: UILabel!
    
    @IBOutlet var separatorView: UIView!
    
    var travel: Travel? {
        didSet {
            guard let image = travel?.travel_image else {return}
            guard let title = travel?.title else {return}
            guard let subTitle = travel?.description else {return}
            guard let grade = travel?.grade else {return}
            guard let save = travel?.save else {return}
            
            let url = URL(string: image)
            mainImageView.kf.setImage(with: url)
            
            titleLabel.text = title
            subTitleLabel.text = subTitle
            gradeLabel.text = "평점 \(grade) ∙ 저장 \(save.formatted())"
        }
    }
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        mainImageView.backgroundColor = .systemGray5
        mainImageView.layer.cornerRadius = 10
        mainImageView.contentMode = .scaleAspectFill
        
        likeButton.tintColor = .white
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        subTitleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        subTitleLabel.textColor = .systemGray
        
        gradeLabel.font = .systemFont(ofSize: 13, weight: .medium)
        gradeLabel.textColor = .systemGray2
    }
}
