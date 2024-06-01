//
//  RestaurantMapViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var filterMark: UILabel!
    
    let restaurants: [Restaurant] = RestaurantList.restaurantArray
    var annotaitons: [MKPointAnnotation] = []
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavi()
        setupMapView(isFirstStart: true)
    }
    
    //MARK: - Configurations
    
    func configureUI () {
        filterMark.clipsToBounds = true
        filterMark.layer.borderColor = UIColor.white.cgColor
        filterMark.layer.borderWidth = 0.8
        filterMark.layer.cornerRadius = 10
        filterMark.font = .boldSystemFont(ofSize: 12)
    }
    
    func setupNavi() {
        let filter = UIBarButtonItem(image: UIImage(named: "필터"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filter
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupMapView(isFirstStart: Bool) {
        if isFirstStart {
            for data in self.restaurants {
                addAnnotation(latitude: data.latitude, longitude: data.longitude, title: data.name)
            }
        } else {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        mapView.addAnnotations(self.annotaitons)
        guard let center = self.annotaitons.randomElement() else {return}
        mapView.setRegion(MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
    }
    
    //MARK: - Functions
    
    func addAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = center
        
        self.annotaitons.append(annotation)
    }
    
    @objc func filterButtonTapped() {
        showActionSheet()
    }
    
    func showActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        self.addAlertAction(alert: alert, title: "전체")
        self.addAlertAction(alert: alert, title: "한식")
        self.addAlertAction(alert: alert, title: "일식")
        self.addAlertAction(alert: alert, title: "중식")
        self.addAlertAction(alert: alert, title: "양식")
        self.addAlertAction(alert: alert, title: "경양식")
        self.addAlertAction(alert: alert, title: "분식")
        self.addAlertAction(alert: alert, title: "카페")
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
    
    func addAlertAction(alert: UIAlertController, title: String) {
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { action in
            self.annotaitons = []
            
            if title == "전체" {
                for data in self.restaurants {
                    self.addAnnotation(latitude: data.latitude, longitude: data.longitude, title: data.name)
                }
            } else {
                let list = self.restaurants.filter { $0.category == title }
                for data in list {
                    self.addAnnotation(latitude: data.latitude, longitude: data.longitude, title: data.name)
                }
            }
            
            self.setupMapView(isFirstStart: false)
        }))
    }
}


