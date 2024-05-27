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
    
    //MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        backView.backgroundColor = .systemCyan
        backView.layer.cornerRadius = 10
        
        titleLabel.textColor = .black
        
        adButton.setTitle("AD", for: .normal)
        adButton.backgroundColor = .white
        adButton.layer.cornerRadius = 12
        adButton.titleLabel?.font = .systemFont(ofSize: 16)
    }
    
    func setupTitleLabel(text: String) {
        let style = NSMutableParagraphStyle()
        let fontSize: CGFloat = 15
        let lineheight = fontSize * 1.6  //font size * multiple
        style.minimumLineHeight = lineheight
        style.maximumLineHeight = lineheight
        
        titleLabel.attributedText = NSAttributedString(
          string: text,
          attributes: [
            .paragraphStyle: style
          ])
        titleLabel.font = .systemFont(ofSize: 15, weight: .heavy)
        titleLabel.textAlignment = .center
    }
}
