//
//  RestaurantMapViewController.swift
//  TravelMagazine
//
//  Created by 권대윤 on 5/30/24.
//



import UIKit
import CoreLocation
import MapKit

class RestaurantMapViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var xMarkButton: UIButton!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    
    var restaurants: [Restaurant] = []
    var annotaitons: [MKPointAnnotation] = []
    
    var filterButtonIsHidden: Bool = false
    
    let locationManager = CLLocationManager()
    
    enum ViewType {
        case mapView
        case restaurantDetail
    }
    var viewType: ViewType = .mapView
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupCLLocation()
        setupMapView(isFirstStart: true)
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
        
        if self.filterButtonIsHidden {
            filterButton.isHidden = true
        } else {
            filterButton.isHidden = false
            filterButton.setTitle("Filter", for: .normal)
            filterButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
            filterButton.tintColor = .white
            filterButton.backgroundColor = .systemBlue
            filterButton.layer.cornerRadius = 10
            filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        }
    }
    
    func setupCLLocation() {
        locationManager.delegate = self
    }
    
    func setupMapView(isFirstStart: Bool) {
        if isFirstStart {
            if restaurants.isEmpty {
                self.restaurants = RestaurantList.restaurantArray
            }
            for data in self.restaurants {
                addAnnotation(latitude: data.latitude, longitude: data.longitude, title: data.name)
            }
        } else {
            if !mapView.annotations.isEmpty {
                mapView.removeAnnotations(mapView.annotations)
            }
        }
        
        mapView.addAnnotations(self.annotaitons)
        
        switch viewType {
        case .mapView:
            let yeongdeungpoCampus = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
            mapView.setRegion(MKCoordinateRegion(center: yeongdeungpoCampus, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
        case .restaurantDetail:
            guard let center = self.annotaitons.randomElement() else {return}
            mapView.setRegion(MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        }
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
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        changeUILocationButton(isActive: false)
        checkDeviceLocationServiceEnabled()
    }
    
    func changeUILocationButton(isActive: Bool) {
        if isActive {
            self.locationButton.isUserInteractionEnabled = true
            self.locationButton.setImage(UIImage(systemName: "location.square"), for: .normal)
        } else {
            self.locationButton.isUserInteractionEnabled = false
            locationButton.setImage(UIImage(systemName: "location.square.fill"), for: .normal)
        }
    }
    
    func checkDeviceLocationServiceEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let status: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    status = self.locationManager.authorizationStatus
                } else {
                    status = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: status)
                }
            } else {
                DispatchQueue.main.async {
                    self.showLocationSettingAlert()
                }   
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showLocationSettingAlert()
            changeUILocationButton(isActive: true)
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            changeUILocationButton(isActive: false)
        default:
            print("Error:", #function)
        }
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.(필수권한)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default, handler: { goSettingAction in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }))
        present(alert, animated: true)
    }
    
    func displayCurrentLocationMapView(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate

extension RestaurantMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate.latitude)
            print(coordinate.longitude)
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: DispatchWorkItem(block: {
                self.displayCurrentLocationMapView(center: coordinate)
                self.locationManager.stopUpdatingLocation()
                self.changeUILocationButton(isActive: true)
            }))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function, error)
        print("실행실행")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.checkDeviceLocationServiceEnabled() //iOS14 이상
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkDeviceLocationServiceEnabled() //iOS14 미만
    }
}


