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
    
    var travel: Travel?
    
    var closureUseForDataSend: (_ data: Travel) -> Void = {(sender) in}
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupNavi()
        configureUI()
    }
    
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
    
    func setupNavi() {
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .white
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.hidesBackButton = true
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
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
    
    //MARK: - Functions
    
    @objc func leftBarButtonTapped() {
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
