//
//  ChatRoomTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/1/24.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var searchWord: String?
    
    var chatRoom: ChatRoom? {
        didSet {
            guard let chatRoom = self.chatRoom else {return}
            guard let date = chatRoom.chatList.last?.date else {return}
            
            profileImageView.image = UIImage(named: chatRoom.chatroomImage[0])
            titleLabel.text = chatRoom.chatroomName
            subtitleLabel.text = chatRoom.chatList.last?.message
            dateLabel.text = Chat.makeDateString(str: date, format: "yy.MM.dd")
            
            highlightSearchWord(word: self.searchWord, label: titleLabel)
        }
    }
    
    //MARK: - Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
        dateLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    //MARK: - Configurations
    
    func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.borderColor = UIColor.systemGray6.cgColor
        profileImageView.layer.borderWidth = 1
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        
        subtitleLabel.font = .boldSystemFont(ofSize: 13)
        subtitleLabel.textColor = .systemGray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
}
