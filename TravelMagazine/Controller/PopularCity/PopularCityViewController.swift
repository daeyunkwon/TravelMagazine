//
//  PopularCityViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit

class PopularCityViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    var citys: [City] = CityInfo.city
    var filterdCitys: [City] = CityInfo.city
    
    var searchWord: String?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupSegment()
        self.setupNavi(title: "인기 도시")
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.placeholder = "검색"
    }
    
    func setupSegment() {
        segment.selectedSegmentIndex = 0
        segment.setTitle("모두", forSegmentAt: 0)
        segment.setTitle("국내", forSegmentAt: 1)
        segment.insertSegment(withTitle: "해외", at: 2, animated: false)
        
        segment.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)
    }
    
    func setupTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: PopularCityTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PopularCityTableViewCell.reuseIdentifier)
    }
    
    //MARK: - Functions
    
    @objc func segmentTapped() {
        self.filterdCitys = []
        let allCitys = CityInfo.city
        
        if segment.selectedSegmentIndex == 0 {
            //전체
            self.filterdCitys = allCitys
            
        } else if segment.selectedSegmentIndex == 1 {
            //국내만 보여주기
            for city in allCitys {
                if city.domestic_travel == true {
                    self.filterdCitys.append(city)
                }
            }
            
        } else if segment.selectedSegmentIndex == 2 {
            //해외만 보여주기
            for city in allCitys {
                if city.domestic_travel == false {
                    self.filterdCitys.append(city)
                }
            }
        }
        
        self.citys = self.filterdCitys
        tableView.reloadData()
    }
}

//MARK: - TableView

extension PopularCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.citys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.reuseIdentifier, for: indexPath) as! PopularCityTableViewCell
        
        cell.searchWord = self.searchWord
        cell.city = citys[indexPath.row]
        
        return cell
    }
}

//MARK: - UISearchBarDelegate

extension PopularCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard var text = searchBar.text else {return}
        
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            self.citys = filterdCitys
            self.searchWord = nil
        } else {
            text = text.lowercased()
            self.searchWord = text
            
            var cityArray: [City] = []
            for city in filterdCitys {
                if city.city_name.contains(text) || city.city_english_name.lowercased().contains(text) || city.city_explain.contains(text) {
                    cityArray.append(city)
                }
            }
            
            self.citys = cityArray
        }
        
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard var text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        text = text.lowercased()
        self.searchWord = text
        
        var cityArray: [City] = []
        for city in filterdCitys {
            if city.city_name.contains(text) || city.city_english_name.lowercased().contains(text) || city.city_explain.contains(text) {
                cityArray.append(city)
            }
        }
        
        self.citys = cityArray
        tableView.reloadData()
    }
}
