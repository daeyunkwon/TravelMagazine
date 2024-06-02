//
//  ChatTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/2/24.
//

import UIKit

class UserChatTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var textBackView: UIView!
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    var chat: Chat? {
        didSet {
            guard let chat = self.chat else {return}
            
            profileImageView.image = UIImage(named: chat.user.profileImage)
            usernameLabel.text = chat.user.rawValue
            messageLabel.text = chat.message
            dateLabel.text = Chat.makeDateString(str: chat.date, format: "HH:MM a")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        usernameLabel.text = nil
        messageLabel.text = nil
        dateLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.backgroundColor = .systemGray5
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.systemGray6.cgColor
        
        usernameLabel.font = .systemFont(ofSize: 14)
        
        textBackView.layer.borderColor = UIColor.separator.cgColor
        textBackView.layer.borderWidth = 1
        textBackView.layer.cornerRadius = 10
        textBackView.clipsToBounds = true
        textBackView.backgroundColor = .whiteToDarkGray
        
        messageLabel.font = .systemFont(ofSize: 14, weight: .medium)
        messageLabel.numberOfLines = 0
        
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
}
