//
//  PopularCityTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var shadowView: UIView!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var imageFrontView: UIView!
    @IBOutlet var labelBackView: UIView!
    
    @IBOutlet var cityExplainLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    
    var searchWord: String?
    var rangeArr: [NSRange] = []
    
    var city: City? {
        didSet {
            guard let city = self.city else {return}
            
            cityImageView.setImageToURL(url: city.city_image)
            cityNameLabel.text = "\(city.city_name) | \(city.city_english_name)"
            cityExplainLabel.text = city.city_explain
            
            highlightSearchWord(word: self.searchWord, label: cityNameLabel)
            highlightSearchWord(word: self.searchWord, label: cityExplainLabel)
        }
    }
    
    //MARK: - Life Cycle
    
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
    
    //MARK: - Configurations
    
    func configureUI() {
        shadowView.backgroundColor = .lightGray
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5) //그림자의 위치(기본 0,0 -> 부모의 위치를 따라감)
        shadowView.layer.shadowOpacity = 1 //그림자 투명도 지정(0 ~ 1)
        shadowView.layer.shadowRadius = 5 //그림자의 블러 정도 지정 (0일때 선같이 진한 그림자 높을 수록 퍼지는 효과)
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        
        cityImageView.contentMode = .scaleAspectFill
        
        cityNameLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .right
        
        cityExplainLabel.textAlignment = .left
        cityExplainLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        cityExplainLabel.textColor = .white
        
        shadowView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        shadowView.layer.cornerRadius = 20
        
        cityImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        cityImageView.layer.cornerRadius = 20
        
        imageFrontView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        imageFrontView.layer.cornerRadius = 20

        labelBackView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        labelBackView.layer.cornerRadius = 20
    }
    
    //MARK: - Functions
    
    func highlightSearchWord(word: String?, label: UILabel) {
        guard let word = word, !word.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        guard let labelText = label.text?.trimmingCharacters(in: .whitespaces) else {return}
        
        rangeArr = []
        
        let attributedStr = NSMutableAttributedString(string: labelText)
        
        findRange(entireString: labelText, searchWord: word)
        
        for range in rangeArr {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        }
        
        label.attributedText = attributedStr
    }
    
    func findRange(entireString: String, searchWord: String) {
        let attributedStr = NSMutableAttributedString(string: entireString)
        let entireLength = entireString.count
        var range = NSRange(location: 0, length: entireLength)
        
        while range.location != NSNotFound {
            range = (attributedStr.string as NSString).range(of: searchWord, options: .caseInsensitive, range: range)
            rangeArr.append(range)
            
            if range.location != NSNotFound {
                range = NSRange(location: range.location + range.length, length: entireLength - (range.location + range.length))
            }
        }
    }
}
