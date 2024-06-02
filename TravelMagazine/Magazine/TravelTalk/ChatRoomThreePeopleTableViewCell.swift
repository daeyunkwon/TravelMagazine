//
//  ChatRoomThreePeopleTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/1/24.
//

import UIKit

class ChatRoomThreePeopleTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var leftProfileImageView: UIImageView!
    @IBOutlet var rightProfileImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var searchWord: String?
    
    var chatRoom: ChatRoom? {
        didSet {
            guard let chatRoom = self.chatRoom else {return}
            guard let date = chatRoom.chatList.last?.date else {return}
            
            leftProfileImageView.image = UIImage(named: chatRoom.chatroomImage[0])
            rightProfileImageView.image = UIImage(named: chatRoom.chatroomImage[1])
            
            titleLabel.text = chatRoom.chatroomName
            subtitleLabel.text = chatRoom.chatList.last?.message
            dateLabel.text = Chat.makeDateString(str: date, format: "yy.MM.dd")
            
            highlightSearchWord(word: self.searchWord, label: titleLabel)
        }
    }
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftProfileImageView.image = nil
        rightProfileImageView.image = nil
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
        leftProfileImageView.layer.cornerRadius = leftProfileImageView.frame.width / 2
        leftProfileImageView.clipsToBounds = true
        leftProfileImageView.contentMode = .scaleAspectFill
        leftProfileImageView.layer.borderColor = UIColor.systemGray6.cgColor
        leftProfileImageView.layer.borderWidth = 1
        
        rightProfileImageView.layer.cornerRadius = rightProfileImageView.frame.width / 2
        rightProfileImageView.clipsToBounds = true
        rightProfileImageView.contentMode = .scaleAspectFill
        rightProfileImageView.layer.borderColor = UIColor.systemGray6.cgColor
        rightProfileImageView.layer.borderWidth = 1
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        
        subtitleLabel.font = .boldSystemFont(ofSize: 13)
        subtitleLabel.textColor = .systemGray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
    
}
