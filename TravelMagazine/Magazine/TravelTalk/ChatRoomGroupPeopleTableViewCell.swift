//
//  ChatRoomGroupPeopleTableViewCell.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/1/24.
//

import UIKit

class ChatRoomGroupPeopleTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet var topLeftProfileImageView: UIImageView!
    @IBOutlet var topRightProfileImageVIew: UIImageView!
    @IBOutlet var bottomLeftProfileImageView: UIImageView!
    @IBOutlet var bottomRightProfileImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var chatRoom: ChatRoom? {
        didSet {
            guard let chatRoom = self.chatRoom else {return}
            guard let date = chatRoom.chatList.last?.date else {return}
            
            topLeftProfileImageView.image = UIImage(named: chatRoom.chatroomImage[0])
            topRightProfileImageVIew.image = UIImage(named: chatRoom.chatroomImage[1])
            bottomLeftProfileImageView.image = UIImage(named: chatRoom.chatroomImage[2])
            bottomRightProfileImageView.image = UIImage(named: chatRoom.chatroomImage[3])
            
            titleLabel.text = chatRoom.chatroomName
            subtitleLabel.text = chatRoom.chatList.last?.message
            dateLabel.text = Chat.makeDateString(str: date, format: "yy.MM.dd")
        }
    }
     
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topLeftProfileImageView.image = nil
        topRightProfileImageVIew.image = nil
        bottomLeftProfileImageView.image = nil
        bottomRightProfileImageView.image = nil
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
        topLeftProfileImageView.layer.cornerRadius = topLeftProfileImageView.frame.width / 2
        topLeftProfileImageView.clipsToBounds = true
        topLeftProfileImageView.contentMode = .scaleAspectFill
        topLeftProfileImageView.layer.borderColor = UIColor.systemGray6.cgColor
        topLeftProfileImageView.layer.borderWidth = 1
        
        topRightProfileImageVIew.layer.cornerRadius = topRightProfileImageVIew.frame.width / 2
        topRightProfileImageVIew.clipsToBounds = true
        topRightProfileImageVIew.contentMode = .scaleAspectFill
        topRightProfileImageVIew.layer.borderColor = UIColor.systemGray6.cgColor
        topRightProfileImageVIew.layer.borderWidth = 1
        
        bottomLeftProfileImageView.layer.cornerRadius = bottomLeftProfileImageView.frame.width / 2
        bottomLeftProfileImageView.clipsToBounds = true
        bottomLeftProfileImageView.contentMode = .scaleAspectFill
        bottomLeftProfileImageView.layer.borderColor = UIColor.systemGray6.cgColor
        bottomLeftProfileImageView.layer.borderWidth = 1
        
        bottomRightProfileImageView.layer.cornerRadius = bottomRightProfileImageView.frame.width / 2
        bottomRightProfileImageView.clipsToBounds = true
        bottomRightProfileImageView.contentMode = .scaleAspectFill
        bottomRightProfileImageView.layer.borderColor = UIColor.systemGray6.cgColor
        bottomRightProfileImageView.layer.borderWidth = 1
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        
        subtitleLabel.font = .boldSystemFont(ofSize: 13)
        subtitleLabel.textColor = .systemGray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
    }
    
}
