//
//  PopularCityTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PopularCityTableViewCell"
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var imageFrontView: UIView!
    @IBOutlet var labelBackView: UIView!
    
    @IBOutlet var cityExplainLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    
    var city: City? {
        didSet {
            guard let city = self.city else {return}
            
            cityImageView.setImageToURL(url: city.city_image)
            cityNameLabel.text = "\(city.city_name) | \(city.city_english_name)"
            cityExplainLabel.text = city.city_explain
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityImageView.image = nil
        cityNameLabel.text = ""
        cityExplainLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        cityImageView.contentMode = .scaleAspectFill
        
        cityNameLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .right
        
        cityExplainLabel.textAlignment = .left
        cityExplainLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        cityExplainLabel.textColor = .white
    }
    
}
