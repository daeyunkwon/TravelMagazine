//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/25/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    @IBOutlet var searchBackView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchTextFieldClearButton: UIButton!
    
    @IBOutlet var optionButtons: [UIButton]!
    
    @IBOutlet var noSearchResultLabel: UILabel!
    
    var restaurants: [Restaurant] = RestaurantList.restaurantArray
    var backupRestaurants: [Restaurant] = RestaurantList.restaurantArray //like 속성값 백업용

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTapGesture()
        setupTableView()
        setupNavi()
    }
    
    //MARK: - Functions
    
    @objc func tapGestureAction() {
        view.endEditing(true)
    }
    
    func likeContextualAction(data: Restaurant, like: Bool, contextualAction: inout UIContextualAction?, indexPath: IndexPath) {
        if like == true {
            contextualAction = UIContextualAction(style: .normal, title: "좋아요") { action, view, completion in
                self.updateLikeValue(restaurant: data)
                self.tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
                completion(true)
            }
            contextualAction?.image = UIImage(systemName: "heart.fill")
        } else {
            contextualAction = UIContextualAction(style: .normal, title: "좋아요 취소") { action, view, completion in
                self.updateLikeValue(restaurant: data)
                self.tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
                completion(true)
            }
            contextualAction?.image = UIImage(systemName: "heart")
        }
    }
    
    @IBAction func searchTextFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else {return}
        
        if text.isEmpty {
            searchTextFieldClearButton.isHidden = true
        } else {
            searchTextFieldClearButton.isHidden = false
        }
    }
    
    @IBAction func searchTextFieldClearButtonTapped(_ sender: UIButton) {
        self.searchTextField.text = nil
        searchTextFieldClearButton.isHidden = true
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        executeSearch()
    }
    
    @IBAction func searchTextFieldReturnKeyTapped(_ sender: UITextField) {
        executeSearch()
    }
    
    func executeSearch() {
        guard var text = searchTextField.text else {return}
        
        text = text.trimmingCharacters(in: .whitespaces)
        
        if text.isEmpty {
            var selectedButton: UIButton = optionButtons[0]
            
            for btn in optionButtons {
                if btn.backgroundColor == UIColor.label {
                    selectedButton = btn
                    break
                }
            }
            
            optionButtonTapped(selectedButton)
        } else {
            self.restaurants = self.restaurants.filter({ res in
                res.name.trimmingCharacters(in: .whitespaces).contains(text)
            })
            
            if restaurants.count == 0 {
                showNoSearchResultLabel()
            } else {
                hideNoSearchResultLabel()
            }
            
            tableView.reloadData()
        }
    }
    
    func showNoSearchResultLabel() {
        self.noSearchResultLabel.isHidden = false
    }
    
    func hideNoSearchResultLabel() {
        self.noSearchResultLabel.isHidden = true
    }
    
    @IBAction func optionButtonTapped(_ sender: UIButton) {
        guard let option = sender.currentTitle else {return}
        
        updateOptionButtonUI(with: sender)
        
        let currentList = self.backupRestaurants
        var newList = RestaurantList.restaurantArray
        
        for i in 0..<currentList.count {
            for j in 0..<newList.count {
                if currentList[i].name == newList[j].name {
                    newList[j].like = currentList[i].like
                }
            }
        }
        
        if sender == optionButtons.first { //전체 버튼 선택
            self.restaurants = newList
        } else { //전체 말고 다른 버튼 선택
            self.restaurants = newList.filter({ res in
                if option == res.category {
                    return true
                }
                return false
            })
        }
        
        if self.restaurants.count == 0 { //검색결과 없는 경우
            showNoSearchResultLabel()
        } else {
            hideNoSearchResultLabel()
        }
        
        tableView.reloadData()
    }
    
    func updateOptionButtonUI(with sender: UIButton) {
        self.optionButtons.forEach { btn in
            if btn == sender { //눌린 경우
                btn.titleLabel?.tintColor = .whiteToDark
                btn.backgroundColor = .label
                btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .black)
            } else { //안눌린 경우
                btn.titleLabel?.tintColor = .label
                btn.backgroundColor = .systemBackground
                btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
            }
        }
    }
    
    func updateLikeValue(restaurant: Restaurant) {
        for i in 0..<self.restaurants.count {
            if self.restaurants[i].name == restaurant.name {
                self.restaurants[i].updateLike()
                break
            }
        }
        
        for i in 0..<self.backupRestaurants.count {
            if self.backupRestaurants[i].name == restaurant.name {
                self.backupRestaurants[i].updateLike()
                break
            }
        }
    }
}

//MARK: - Configurations

extension RestaurantTableViewController {
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
    }
    
    func setupNavi() {
        navigationItem.title = "식당"
    }
    
    func configureUI() {
        searchBackView.backgroundColor = .systemGray5
        searchBackView.layer.cornerRadius = 20
        
        searchTextField.borderStyle = .none
        searchTextField.tintColor = .label
        searchTextField.textColor = .label
        searchTextField.placeholder = "식당명 검색"
        searchTextField.returnKeyType = .search
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
        
        searchButton.setTitle("", for: .normal)
        searchButton.tintColor = .lightGray
        
        searchTextFieldClearButton.setTitle("", for: .normal)
        searchTextFieldClearButton.tintColor = .lightGray
        searchTextFieldClearButton.isHidden = true
        
        for btn in optionButtons {
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 15
            btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
            
            if btn == optionButtons.first {
                btn.titleLabel?.tintColor = .whiteToDark
                btn.backgroundColor = .label
                btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .black)
            } else {
                btn.titleLabel?.tintColor = .label
                btn.backgroundColor = .systemBackground
            }
        }
        
        noSearchResultLabel.text = "검색 결과가 없습니다."
        noSearchResultLabel.font = .boldSystemFont(ofSize: 20)
        noSearchResultLabel.isHidden = true
    }
}

//MARK: - RestaurantTableViewCellDelegate

extension RestaurantTableViewController: RestaurantTableViewCellDelegate {
    func handleLikeButtonTapped(for cell: RestaurantTableViewCell) {
        guard let restaurant = cell.restaurant else {return}
        
        updateLikeValue(restaurant: restaurant)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension RestaurantTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.reuseIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.delegate = self
        
        cell.restaurant = self.restaurants[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var contextualAction: UIContextualAction?
        
        let data = restaurants[indexPath.row]
        
        if data.like == false {
            likeContextualAction(data: data, like: true, contextualAction: &contextualAction, indexPath: indexPath)
        } else {
            likeContextualAction(data: data, like: false, contextualAction: &contextualAction, indexPath: indexPath)
        }
        
        guard let contextualAction else {return nil}
        contextualAction.backgroundColor = UIColor(red: 0.96, green: 0.46, blue: 0.56, alpha: 1.00)
        let config = UISwipeActionsConfiguration(actions: [contextualAction])
        config.performsFirstActionWithFullSwipe = false //풀 스와이프 비허용 설정
        return config
    }
}
