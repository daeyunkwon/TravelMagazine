//
//  AdTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var backView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adButton: UIButton!
    
    var randomBackgroundColorList: [UIColor] = [
        UIColor.rgb(red: 250, green: 187, blue: 200),
        UIColor.rgb(red: 139, green: 206, blue: 228),
        UIColor.rgb(red: 249, green: 215, blue: 128),
        UIColor.rgb(red: 171, green: 182, blue: 251),
        UIColor.rgb(red: 160, green: 216, blue: 161),
    ]
    
    var travel: Travel? {
        didSet {
            guard let travel = self.travel else {return}
            guard let title = travel.title else {return}
            
            self.setupTitleLabel(text: title)
        }
    }
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        backView.backgroundColor = randomBackgroundColorList.randomElement()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    //MARK: - Configurations
    
    func configureUI() {
        backView.backgroundColor = randomBackgroundColorList.randomElement()
        backView.layer.cornerRadius = 10
        
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        adButton.setTitle("AD", for: .normal)
        adButton.backgroundColor = .white
        adButton.layer.cornerRadius = 10
        adButton.titleLabel?.font = .systemFont(ofSize: 11)
        adButton.sizeToFit()
    }
    
    //MARK: - Functions
    
    func setupTitleLabel(text: String) {
        let attrString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        titleLabel.attributedText = attrString
        titleLabel.font = .systemFont(ofSize: 15, weight: .heavy)
        titleLabel.textAlignment = .center
    }
}
