//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/25/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    @IBOutlet var searchBackView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var optionButtons: [UIButton]!
    
    @IBOutlet var noSearchResultLabel: UILabel!
        
    var restaurants: [Restaurant] = RestaurantList.restaurantArray

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGesture()
        setupTableView()
        setupNavi()
        configureUI()
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
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
        
        searchButton.setTitle("", for: .normal)
        searchButton.tintColor = .lightGray
        
        for btn in optionButtons {
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 15
            btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
            
            if btn == optionButtons.first {
                btn.titleLabel?.tintColor = .optionButton
                btn.backgroundColor = .label
            } else {
                btn.titleLabel?.tintColor = .label
                btn.backgroundColor = .systemBackground
            }
        }
        
        noSearchResultLabel.text = "검색 결과가 없습니다."
        noSearchResultLabel.font = .boldSystemFont(ofSize: 20)
        noSearchResultLabel.isHidden = true
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        cell.restaurant = self.restaurants[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: - Functions
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        executeSearch()
    }
    
    @IBAction func searchTextFieldReturnKeyTapped(_ sender: UITextField) {
        print(#function)
        executeSearch()
    }
    
    func executeSearch() {
        guard var text = searchTextField.text else {return}
        
        text = text.trimmingCharacters(in: .whitespaces)
        
        if text == "" {
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
        
        updateOptionButtonState(with: sender)
        
        if sender == optionButtons.first {
            self.restaurants = RestaurantList.restaurantArray
        } else {
            self.restaurants = RestaurantList.restaurantArray.filter({ res in
                if option == res.category {
                    return true
                }
                return false
            })
        }
        
        if self.restaurants.count == 0 {
            showNoSearchResultLabel()
        } else {
            hideNoSearchResultLabel()
        }
        
        tableView.reloadData()
    }
    
    func updateOptionButtonState(with sender: UIButton) {
        self.optionButtons.forEach { btn in
            if btn == sender {
                btn.titleLabel?.tintColor = .optionButton
                btn.backgroundColor = .label
            } else {
                btn.titleLabel?.tintColor = .label
                btn.backgroundColor = .systemBackground
            }
        }
    }
}
