//
//  CityDetailViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit
import Cosmos

class CityDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cosmosView: CosmosView!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    
    var travel: Travel?
    
    var closureUseForDataSend: (_ data: Travel) -> Void = {(sender) in}
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        configureUI()
    }
    
    //MARK: - Configurations
    
    func setupData() {
        guard let travel = self.travel else {return}
        guard let travel_image = travel.travel_image else {return}
        guard let save = travel.save else {return}
        guard let grade = travel.grade else {return}
        guard let like = travel.like else {return}
        
        mainImageView.setImageToURL(url: travel_image)
        titleLabel.text = travel.title
        descriptionLabel.text = travel.description
        saveLabel.text = "∙ 저장 \(save.formatted())"
        
        updateLikeButtonUI(isLike: like)
        
        cosmosView.rating = grade
        cosmosView.text = "(\(grade))"
    }
    
    func configureUI() {
        titleLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        titleLabel.textColor = .white
        
        mainImageView.contentMode = .scaleAspectFill
        
        saveLabel.font = .systemFont(ofSize: 15)
        saveLabel.textColor = .lightGray
        
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        
        likeButton.tintColor = .white
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        backButton.setTitle("", for: .normal)
        backButton.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        backButton.setImage(image, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        cosmosView.settings.filledColor = .systemYellow
        cosmosView.settings.totalStars = 5
        cosmosView.settings.emptyColor = .systemGray5
        cosmosView.settings.emptyBorderWidth = 0
        cosmosView.settings.filledBorderWidth = 0
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.disablePanGestures = false
        cosmosView.backgroundColor = .clear
        cosmosView.settings.textColor = .systemGray2
        cosmosView.settings.textFont = .systemFont(ofSize: 15, weight: .medium)
        cosmosView.settings.starSize = 15
        cosmosView.settings.starMargin = 1
    }
    
    //MARK: - Functions

    func updateLikeButtonUI(isLike: Bool) {
        if isLike {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
            let heart = UIImage(systemName: "heart.fill", withConfiguration: largeConfig)
            likeButton.setImage(heart, for: .normal)
        } else {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
            let heart = UIImage(systemName: "heart", withConfiguration: largeConfig)
            likeButton.setImage(heart, for: .normal)
        }
    }
    
    @objc func backButtonTapped() {
        guard let travel = self.travel else {return}
        self.closureUseForDataSend(travel)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func likeButtonTapped() {
        self.travel?.like?.toggle()
        guard let like = travel?.like else {return}
        updateLikeButtonUI(isLike: like)
    }
}
