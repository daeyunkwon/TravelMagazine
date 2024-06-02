//
//  MeChatTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/2/24.
//

import UIKit

class MeChatTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var backView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var chat: Chat? {
        didSet {
            guard let chat = self.chat else {return}
            
            messageLabel.text = chat.message
            dateLabel.text = Chat.makeDateString(str: chat.date, format: "HH:MM a")
        }
    }
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = nil
        dateLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    //MARK: - Configurations
    
    func configureUI() {
        backView.layer.borderColor = UIColor.separator.cgColor
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        backView.backgroundColor = UIColor.customBlue()
        
        messageLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .white
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
}
