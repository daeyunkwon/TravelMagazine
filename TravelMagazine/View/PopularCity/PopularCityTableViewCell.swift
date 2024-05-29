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
