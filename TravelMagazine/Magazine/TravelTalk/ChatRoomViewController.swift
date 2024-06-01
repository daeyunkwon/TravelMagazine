//
//  ChatRoomViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/1/24.
//

import UIKit

class ChatRoomViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let chatRoomList: [ChatRoom] = mockChatList
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupSearchBar()
        setupTableView()
    }
    
    //MARK: - Configurations
    
    func setupNavi() {
        setupNavi(title: "TRAVEL TALK", isShowSeparator: false)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
    }
    
    func setupSearchBar() {
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.whiteToDark.cgColor
        
        searchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: ChatRoomTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ChatRoomTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: ChatRoomThreePeopleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ChatRoomThreePeopleTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: ChatRoomFourPeopleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ChatRoomFourPeopleTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: ChatRoomGroupPeopleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ChatRoomGroupPeopleTableViewCell.reuseIdentifier)
    }
    
    //MARK: - Functions
    

    
}

//MARK: - UITableViewDataSource & UITableViewDelegate

extension ChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch chatRoomList[indexPath.row].chatroomImage.count {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomTableViewCell
            cell.chatRoom = self.chatRoomList[indexPath.row]
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomThreePeopleTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomThreePeopleTableViewCell
            cell.chatRoom = self.chatRoomList[indexPath.row]
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomFourPeopleTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomFourPeopleTableViewCell
            cell.chatRoom = self.chatRoomList[indexPath.row]
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomGroupPeopleTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomGroupPeopleTableViewCell
            cell.chatRoom = self.chatRoomList[indexPath.row]
        default: break
        }
        
        return UITableViewCell()
    }
    
    
}

//MARK: - UISearchBarDelegate

extension ChatRoomViewController: UISearchBarDelegate {
    
}
