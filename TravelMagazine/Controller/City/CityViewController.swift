//
//  CityViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/27/24.
//

import UIKit


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
        tableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.register(UINib(nibName: AdTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AdTableViewCell.identifier)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if travels[indexPath.row].ad == true { 
            //AdCell 표시
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.setupTitleLabel(text: travels[indexPath.row].title ?? "")
            return cell
        } else {
            //CityCell 표시
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = travels[indexPath.row]
        
        if !data.ad {
            let sb = UIStoryboard(name: "CityDetail", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CityDetailViewController") as! CityDetailViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let sb = UIStoryboard(name: "AdDetail", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "AdDetailViewController") as! AdDetailViewController
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .fullScreen
            present(navi, animated: true)
        }
        
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
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
