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
    @IBOutlet var xMarkButton: UIButton!
    @IBOutlet var filterButton: UIButton!
    
    let restaurants: [Restaurant] = RestaurantList.restaurantArray
    var annotaitons: [MKPointAnnotation] = []
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupMapView(isFirstStart: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Configurations
    
    func configureUI () {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        let xmark = UIImage(systemName: "xmark", withConfiguration: symbolConfig)
        
        xMarkButton.setImage(xmark, for: .normal)
        xMarkButton.setTitle("", for: .normal)
        xMarkButton.tintColor = .label
        if #available(iOS 17.0, *) {
            xMarkButton.isSymbolAnimationEnabled = true
        }
        xMarkButton.addTarget(self, action: #selector(xMarkButtonTapped), for: .touchUpInside)
        
        filterButton.setTitle("Filter", for: .normal)
        filterButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        filterButton.tintColor = .white
        filterButton.backgroundColor = .systemBlue
        filterButton.layer.cornerRadius = 10
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
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
    
    @objc func xMarkButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func filterButtonTapped() {
        showActionSheet()
    }
    
    func addAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = center
        
        self.annotaitons.append(annotation)
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


