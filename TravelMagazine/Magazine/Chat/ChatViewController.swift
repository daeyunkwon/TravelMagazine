//
//  ChatViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 6/2/24.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var textBackView: UIView!
    
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    var chatList: [Chat] = []

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTapGesture()
        scrollTableViewToBottom()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    func configureUI() {
        textBackView.backgroundColor = .systemGray6
        textBackView.layer.cornerRadius = 10
        
        textView.text = "메시지를 입력하세요"
        textView.textColor = .lightGray
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.isScrollEnabled = false
        
        sendButton.setTitle("", for: .normal)
        sendButton.setImage(UIImage(systemName: "paperplane.circle"), for: .normal)
        sendButton.tintColor = UIColor.customBlue()
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let keybaordRectangle = keyboardFrame.cgRectValue
          let keyboardHeight = keybaordRectangle.height
          textBackView.frame.origin.y -= keyboardHeight - 20
            sendButton.frame.origin.y -= keyboardHeight - 20
            textView.frame.origin.y -= keyboardHeight - 20
            view.frame.origin.y -= keyboardHeight - 20
        }
        scrollTableViewToBottom()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let keybaordRectangle = keyboardFrame.cgRectValue
          let keyboardHeight = keybaordRectangle.height
            textBackView.frame.origin.y += keyboardHeight - 20
            sendButton.frame.origin.y += keyboardHeight - 20
            textView.frame.origin.y += keyboardHeight - 20
            view.frame.origin.y += keyboardHeight - 20
        }
        scrollTableViewToBottom()
    }
    
    @objc func sendButtonTapped() {
        print(#function)
    }
    
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

        self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
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

//MARK: - UITextViewDelegate

extension ChatViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "메시지를 입력하세요" && textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty && textView.textColor == UIColor.label {
            textView.text = "메시지를 입력하세요"
            textView.textColor = .lightGray
        }
    }
}
