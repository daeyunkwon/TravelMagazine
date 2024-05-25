//
//  MagazineTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/24/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var magazine: Magazine? {
        didSet {
            guard let magazine = magazine else {return}
            
            let url = URL(string: magazine.photo_image)
            mainImageView.kf.setImage(with: url)
            
            titleLabel.text = magazine.title
            subTitleLabel.text = magazine.subtitle
            dateLabel.text = self.makeDateString(str: magazine.date)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        dateLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        mainImageView.layer.cornerRadius = 10
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.backgroundColor = .systemGray5
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subTitleLabel.textColor = .systemGray
        subTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        dateLabel.textAlignment = .right
    }
    
    func makeDateString(str: String) -> String {
        //String -> Date로 변환하기
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyMMdd"  // String의 문자열 형식과 동일 해야함
        myFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        let date = myFormatter.date(from: str) ?? Date()
        
        //원하는 format으로 표시하기 위해 다시 Date -> String 으로 변환하기
        myFormatter.dateFormat = "yy년 M월 d일"
        let dateString = myFormatter.string(from: date)
        
        return dateString
    }

}
