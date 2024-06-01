//
//  ViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/24/24.
//

import UIKit
import Kingfisher

class MagazineViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    var magazines: [Magazine] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        self.setupNavi(title: "SaSAC TRAVEL")
        setupTableView()
    }
    
    func setupData() {
        magazines = MagazineInfo.magazine
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
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


