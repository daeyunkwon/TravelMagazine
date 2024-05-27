//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/25/24.
//

import UIKit

private let reuseIdentifier = "RestaurantTableViewCell"

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
        setupTapGesture()
        setupTableView()
        setupNavi()
        configureUI()
    }
    
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

    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.delegate = self
        
        cell.restaurant = self.restaurants[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: - Functions
    
    @objc func tapGestureAction() {
        view.endEditing(true)
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
}

//MARK: - RestaurantTableViewCellDelegate

extension RestaurantTableViewController: RestaurantTableViewCellDelegate {
    func handleLikeButtonTapped(for cell: RestaurantTableViewCell) {
        for i in 0..<self.restaurants.count {
            if self.restaurants[i].name == cell.restaurant?.name {
                self.restaurants[i].updateLike()
                break
            }
        }
        
        for i in 0..<self.backupRestaurants.count {
            if self.backupRestaurants[i].name == cell.restaurant?.name {
                self.backupRestaurants[i].updateLike()
                break
            }
        }
        
        tableView.reloadData()
    }
}
