//
//  ViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/24/24.
//

import UIKit

class MagazineViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    var magazines: [Magazine] = []
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        setupNavi(title: "SaSAC TRAVEL", isShowSeparator: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupData()
        setupTableView()
    }
    
    func setupNavi() {
        self.setupNavi(title: "SaSAC TRAVEL", isShowSeparator: true)
        
        let chat = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(chatButtonTapped))
        if #available(iOS 17.0, *) {
            chat.isSymbolAnimationEnabled = true
        }
        navigationItem.rightBarButtonItem = chat
    }
    
    func setupData() {
        magazines = MagazineInfo.magazine
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    //MARK: - Functions
    
    @objc func chatButtonTapped() {
        let sb = UIStoryboard(name: "ChatRoom", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ChatRoomViewController.reuseIdentifier) as! ChatRoomViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TableView

extension MagazineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.reuseIdentifier, for: indexPath) as! MagazineTableViewCell
        
        cell.magazine = self.magazines[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
}


