//
//  ViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/24/24.
//

import UIKit
import Kingfisher

class MagazineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var magazines: [Magazine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupNavi()
        setupTableView()
    }
    
    func setupData() {
        magazines = MagazineInfo.magazine
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavi() {
        navigationItem.title = "SaSAC TRAVEL"
    }
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        
        cell.magazine = self.magazines[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    


}


