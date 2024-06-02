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
    
    var chatRoomList: [ChatRoom] = mockChatList {
        didSet {
            chatRoomList.sort {
                let firstDateString = $0.chatList.last?.date ?? ""
                let secondDateString = $1.chatList.last?.date ?? ""
                
                let firstDate = Chat.makeDate(str: firstDateString)
                let secondDate = Chat.makeDate(str: secondDateString)
                
                return firstDate > secondDate //최신순 정렬
            }
            tableView.reloadData()
        }
    }
    
    var searchText: String?
    
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
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.setupSearchBar(placeholder: "친구 이름을 검색해보세요")
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
            cell.searchWord = self.searchText
            cell.chatRoom = self.chatRoomList[indexPath.row]
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomThreePeopleTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomThreePeopleTableViewCell
            cell.searchWord = self.searchText
            cell.chatRoom = self.chatRoomList[indexPath.row]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomFourPeopleTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomFourPeopleTableViewCell
            cell.searchWord = self.searchText
            cell.chatRoom = self.chatRoomList[indexPath.row]
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomGroupPeopleTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomGroupPeopleTableViewCell
            cell.searchWord = self.searchText
            cell.chatRoom = self.chatRoomList[indexPath.row]
            return cell
        default: break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.chatRoomList[indexPath.row].chatroomName)
    }
}

//MARK: - UISearchBarDelegate

extension ChatRoomViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else {return}
        
        let text = searchBarText.trimmingCharacters(in: .whitespaces).lowercased()
        
        if text.isEmpty {
            self.searchText = nil
            self.chatRoomList = mockChatList
        } else {
            self.searchText = text
            var filterd: [ChatRoom] = []
            for item in mockChatList {
                if item.chatroomName.lowercased().contains(text) {
                    filterd.append(item)
                }
            }
            self.chatRoomList = filterd
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
