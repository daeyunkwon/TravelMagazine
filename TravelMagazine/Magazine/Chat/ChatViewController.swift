//
//  ChatViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/2/24.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    var chatList: [Chat] = []

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTapGesture()
        scrollTableViewToBottom()
    }
    
    //MARK: - Configurations
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserChatTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UserChatTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: MeChatTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MeChatTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: DateSeparatorTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DateSeparatorTableViewCell.reuseIdentifier)
    }
    
    func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Functions
    
    @objc func tapGesture() {
        view.endEditing(true)
    }
    
    func checkAndAddNewDate() { //날짜가 달라졌을 때, 날짜 구분선용 Chat 데이터를 추가합니다. (달라진게 없으면 추가X)
        let dateStringList = chatList.map{
            Chat.makeDateString(str: $0.date, format: "yyyy-MM-dd")
        }
        
        for i in 0..<dateStringList.count {
            if i == dateStringList.count-1 {
                break
            }
            
            if dateStringList[i] != dateStringList[i+1] {
                chatList.insert(Chat(user: User.dateSeparator, date: dateStringList[i], message: "n/a"), at: i+1)
            }
        }
    }
    
    func scrollTableViewToBottom() {
        let index = IndexPath(row: self.chatList.count - 1, section: 0)
        self.tableView.scrollToRow(at: index, at: .bottom, animated: true)
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if chatList[indexPath.row].user == .dateSeparator {
            return 60
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if chatList[indexPath.row].user == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: MeChatTableViewCell.reuseIdentifier, for: indexPath) as! MeChatTableViewCell
            cell.chat = self.chatList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else if chatList[indexPath.row].user == .dateSeparator {
            let cell = tableView.dequeueReusableCell(withIdentifier: DateSeparatorTableViewCell.reuseIdentifier, for: indexPath) as! DateSeparatorTableViewCell
            cell.chat = self.chatList[indexPath.row]
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserChatTableViewCell.reuseIdentifier, for: indexPath) as! UserChatTableViewCell
            cell.chat = self.chatList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
}
