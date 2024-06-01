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
    
    var cities: [City] = CityInfo.city
    var filterdCities: [City] = CityInfo.city
    
    var searchWord: String?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGesture()
        setupSearchBar()
        setupSegment()
        self.setupNavi(title: "인기 도시")
        setupTableView()
    }
    
    //MARK: - Configurations
    
    func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
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
    
    @objc func tapGesture() {
        view.endEditing(true)
    }
    
    @objc func segmentTapped() {
        self.filterdCities = []
        let allCities = CityInfo.city
        
        if segment.selectedSegmentIndex == 0 {
            //전체
            for city in allCities {
                filterdCitiesByKeywordOrNot(city: city)
            }
            
        } else if segment.selectedSegmentIndex == 1 {
            //국내만 보여주기
            for city in allCities {
                if city.domestic_travel == true {
                    filterdCitiesByKeywordOrNot(city: city)
                }
            }
            
        } else if segment.selectedSegmentIndex == 2 {
            //해외만 보여주기
            for city in allCities {
                if city.domestic_travel == false {
                    filterdCitiesByKeywordOrNot(city: city)
                }
            }
        }
        
        self.cities = self.filterdCities
        tableView.reloadData()
    }
    
    func filterdCitiesByKeywordOrNot(city: City) {
        if var text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            text = text.lowercased()
            self.searchWord = text
            
            if city.city_name.contains(text) || city.city_english_name.lowercased().contains(text) || city.city_explain.contains(text) {
                self.filterdCities.append(city)
            }
        } else {
            self.filterdCities.append(city)
        }
    }
}

//MARK: - TableView

extension PopularCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.reuseIdentifier, for: indexPath) as! PopularCityTableViewCell
        
        cell.searchWord = self.searchWord
        cell.city = cities[indexPath.row]
        
        return cell
    }
}

//MARK: - UISearchBarDelegate

extension PopularCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var text = searchBar.text else {return}
        
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            self.cities = filterdCities
            self.searchWord = nil
        } else {
            text = text.lowercased()
            self.searchWord = text
            
            var cityArray: [City] = []
            for city in filterdCities {
                if city.city_name.contains(text) || city.city_english_name.lowercased().contains(text) || city.city_explain.contains(text) {
                    cityArray.append(city)
                }
            }
            
            self.cities = cityArray
        }
        
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard var text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            segmentTapped()
            return
        }
        
        text = text.lowercased()
        self.searchWord = text
        
        var cityArray: [City] = []
        for city in filterdCities {
            if city.city_name.contains(text) || city.city_english_name.lowercased().contains(text) || city.city_explain.contains(text) {
                cityArray.append(city)
            }
        }
        
        self.cities = cityArray
        tableView.reloadData()
    }
}
