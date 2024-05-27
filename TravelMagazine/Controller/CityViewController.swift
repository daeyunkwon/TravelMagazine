//
//  CityViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/27/24.
//

import UIKit

private let reuseCityCell = "CityTableViewCell"
private let reuseAdCell = "AdTableViewCell"

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    var travels: [Travel] = TravelInfo.travel
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupTableView()
    }
    
    func setupNavi() {
        navigationItem.title = "도시 상세 정보"
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: reuseCityCell)
        tableView.register(UINib(nibName: "AdTableViewCell", bundle: nil), forCellReuseIdentifier: reuseAdCell)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travels[indexPath.row].ad == false {
            //CityCell 높이 설정
            return 150
        } else {
            //AdCell 높이 설정
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if travels[indexPath.row].ad == true { 
            //AdCell 표시
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseAdCell, for: indexPath) as! AdTableViewCell
            cell.setupTitleLabel(text: travels[indexPath.row].title ?? "")
            return cell
        } else {
            //CityCell 표시
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseCityCell, for: indexPath) as! CityTableViewCell
            cell.delegate = self
            cell.travel = self.travels[indexPath.row]
            if indexPath.row+1 < travels.count && travels[indexPath.row + 1].ad == true {
                cell.separatorView.isHidden = true
            } else {
                cell.separatorView.isHidden = false
            }
            return cell
        }
    }
}

//MARK: - CityTableViewCellDelegate

extension CityViewController: CityTableViewCellDelegate {
    func handleLikeButtonTapped(for cell: CityTableViewCell) {
        guard let currentValue = cell.travel?.like else {return}
        
        for i in 0..<travels.count {
            if travels[i].title == cell.travel?.title {
                travels[i].like = !currentValue
                tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .none)
                break
            }
        }
    }
}
