//
//  PopularCityViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/29/24.
//

import UIKit

class PopularCityViewController: UIViewController {
    
    //MARK: - Properties
    
    let viewModel = PopularCityViewModel()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGesture()
        setupSearchBar()
        setupSegment()
        self.setupNavi(title: "인기 도시", isShowSeparator: true)
        setupTableView()
        bind()
    }
    
    //MARK: - Configurations
    
    func bind() {
        viewModel.outputCities.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.setupSearchBar(placeholder: "검색")
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
        viewModel.inputSegmentTapped.value = segment.selectedSegmentIndex
    }
}

//MARK: - TableView

extension PopularCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.outputCities.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.reuseIdentifier, for: indexPath) as! PopularCityTableViewCell
        
        cell.searchWord = viewModel.searchKeyword
        cell.city = viewModel.outputCities.value[indexPath.row]
        
        return cell
    }
}

//MARK: - UISearchBarDelegate

extension PopularCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var text = searchBar.text ?? ""
        text = text.lowercased()
        viewModel.inputSearchBarText.value = text
    }
}
