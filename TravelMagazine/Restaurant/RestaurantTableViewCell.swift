//
//  RestaurantTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/25/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var likeButton: UIButton!
    
    weak var delegate: RestaurantTableViewCellDelegate?
    
    var restaurant: Restaurant? {
        didSet {
            guard let restaurant else {return}
            
            mainImageView.setImageToURL(url: restaurant.image)
            
            nameLabel.text = restaurant.name
            categoryLabel.text = restaurant.category
            phoneNumberLabel.text = restaurant.phoneNumber
            addressLabel.text = restaurant.address
            priceLabel.text = "가격대: " + restaurant.priceString
            
            setupLikeButtonImage(isLike: restaurant.like)
        }
    }
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        nameLabel.text = ""
        categoryLabel.text = ""
        phoneNumberLabel.text = ""
        addressLabel.text = ""
        priceLabel.text = ""
        
        setupLikeButtonImage(isLike: false)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
    
    func configureUI() {
        self.backgroundColor = .systemGray5
        
        backView.backgroundColor = .systemBackground
        backView.layer.cornerRadius = 10
        
        mainImageView.backgroundColor = .systemGray5
        mainImageView.layer.cornerRadius = 10
        mainImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        nameLabel.numberOfLines = 2
        
        categoryLabel.textColor = .systemGray
        categoryLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        phoneNumberLabel.textColor = .label
        phoneNumberLabel.font = .systemFont(ofSize: 14)
        
        addressLabel.textColor = .label
        addressLabel.font = .systemFont(ofSize: 14)
        
        priceLabel.textColor = .label
        priceLabel.font = .boldSystemFont(ofSize: 14)
        
        likeButton.tintColor = UIColor.customPink()
        likeButton.setTitle("", for: .normal)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        if #available(iOS 17.0, *) {
            likeButton.isSymbolAnimationEnabled = true
        }
    }
    
    func setupLikeButtonImage(isLike: Bool) {
        if isLike == false {
            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let symbolImage = UIImage(systemName: "heart", withConfiguration: symbolConfig)
            likeButton.setImage(symbolImage, for: .normal)
            likeButton.tintColor = UIColor(red: 0.96, green: 0.46, blue: 0.56, alpha: 1.00)
        } else {
            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let symbolImage = UIImage(systemName: "heart.fill", withConfiguration: symbolConfig)
            likeButton.setImage(symbolImage, for: .normal)
            likeButton.tintColor = UIColor(red: 0.96, green: 0.46, blue: 0.56, alpha: 1.00)
        }
    }
    
    //MARK: - Functions
    
    @objc func likeButtonTapped() {
        self.delegate?.handleLikeButtonTapped(for: self)
    }
}
