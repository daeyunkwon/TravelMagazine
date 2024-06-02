//
//  DateSeparatorTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/2/24.
//

import UIKit

class DateSeparatorTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var backView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    var chat: Chat? {
        didSet {
            guard let chat = self.chat else {return}
            
            dateLabel.text = self.changeDateFormat(str: chat.date, format: "yyyy년 M월 d일 EEE요일")
        }
    }
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    //MARK: - Configurations
    
    func configure() {
        backView.backgroundColor = .systemGray5
        backView.layer.cornerRadius = 15
        
        dateLabel.font = .boldSystemFont(ofSize: 11)
        dateLabel.textColor = .darkGray
    }
    
    //MARK: - Functions
    
    func changeDateFormat(str: String, format: String) -> String {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"  // String의 문자열 형식과 동일 해야함
        myFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        let date = myFormatter.date(from: str) ?? Date()
        
        //원하는 format으로 표시하기 위해 다시 Date -> String 으로 변환하기
        myFormatter.dateFormat = format
        myFormatter.locale = Locale(identifier: "ko-KR")
        let dateString = myFormatter.string(from: date)
        
        return dateString
    }
}
