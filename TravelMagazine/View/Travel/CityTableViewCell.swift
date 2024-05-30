//
//  CityTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/27/24.
//

import UIKit
import Kingfisher
import Cosmos

class CityTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "CityTableViewCell"
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var saveLabel: UILabel!
    
    @IBOutlet var separatorView: UIView!
    
    @IBOutlet var cosmosView: CosmosView!
    
    var travel: Travel? {
        didSet {
            guard let image = travel?.travel_image else {return}
            guard let title = travel?.title else {return}
            guard let subTitle = travel?.description else {return}
            guard let grade = travel?.grade else {return}
            guard let save = travel?.save else {return}
            guard let like = travel?.like else {return}
            
            mainImageView.setImageToURL(url: image)
            
            titleLabel.text = title
            subTitleLabel.text = subTitle
            saveLabel.text = "∙ 저장 \(save.formatted())"
            
            updateLikeButtonUI(isLike: like)
            
            cosmosView.rating = grade
            cosmosView.text = "(\(grade))"
        }
    }
    
    weak var delegate: CityTableViewCellDelegate?
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        titleLabel.text = ""
        subTitleLabel.text = ""
        saveLabel.text = ""
        cosmosView.rating = 0
        cosmosView.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        setupLikeButton()
    }
    
    func configureUI() {
        mainImageView.backgroundColor = .systemGray5
        mainImageView.layer.cornerRadius = 10
        mainImageView.contentMode = .scaleAspectFill
        
        likeButton.tintColor = .white
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        subTitleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        subTitleLabel.textColor = .systemGray
        subTitleLabel.numberOfLines = 0
        
        saveLabel.font = .systemFont(ofSize: 13, weight: .medium)
        saveLabel.textColor = .systemGray2
        
        cosmosView.settings.filledColor = .systemYellow
        cosmosView.settings.totalStars = 5
        cosmosView.settings.emptyColor = .systemGray5
        cosmosView.settings.emptyBorderWidth = 0
        cosmosView.settings.filledBorderWidth = 0
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.disablePanGestures = false
        cosmosView.backgroundColor = .clear
        cosmosView.settings.textColor = .systemGray2
        cosmosView.settings.textFont = .systemFont(ofSize: 13, weight: .medium)
        cosmosView.settings.starSize = 12
        cosmosView.settings.starMargin = 1
        // Set image for the filled star
        cosmosView.settings.filledImage = UIImage(named: "GoldStarFilled")
        // Set image for the empty star
        cosmosView.settings.emptyImage = UIImage(named: "GoldStarEmpty")
    }
    
    func setupLikeButton() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    func updateLikeButtonUI(isLike: Bool) {
        if isLike {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    //MARK: - Functions
    
    @objc func likeButtonTapped() {
        self.delegate?.handleLikeButtonTapped(for: self)
    }
}
