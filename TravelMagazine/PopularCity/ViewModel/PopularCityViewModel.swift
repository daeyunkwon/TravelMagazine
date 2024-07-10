//
//  PopularCityViewModel.swift
//  TravelMagazine
//
//  Created by 권대윤 on 7/9/24.
//

import Foundation

final class PopularCityViewModel {
    
    //MARK: - Properties
    
    private(set) var searchKeyword: String?
    
    //MARK: - Input
    
    var inputSegmentTapped = Observable<Int?>(0)
    
    var inputSearchBarText = Observable<String?>(nil)
    
    //MARK: - Ouput
    
    var outputFilteredCities = Observable<[City]>(CityInfo.city)
    
    var outputCities = Observable<[City]>(CityInfo.city)
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSegmentTapped.bind { number in
            guard let number = number else { return }
            self.setupFilteredCities(num: number)
            self.outputCities.value = self.outputFilteredCities.value
        }
        
        inputSearchBarText.bind { searchText in
            self.searchKeyword = searchText
            self.filteredCitiesWithSearchKeyword(text: self.searchKeyword ?? "")
        }
    }
    
    //MARK: - Functions

    private func setupFilteredCities(num: Int) {
        
        self.outputFilteredCities.value = []
        let allCities = CityInfo.city
        
        if num == 0 {
            //전체
            for city in allCities {
                filteredCitiesByKeywordOrNot(city: city)
            }
            
        } else if num == 1 {
            //국내만 보여주기
            for city in allCities {
                if city.domestic_travel == true {
                    filteredCitiesByKeywordOrNot(city: city)
                }
            }
            
        } else if num == 2 {
            //해외만 보여주기
            for city in allCities {
                if city.domestic_travel == false {
                    filteredCitiesByKeywordOrNot(city: city)
                }
            }
        }
        self.outputCities.value = self.outputFilteredCities.value
    }
    
    private func filteredCitiesByKeywordOrNot(city: City) {
        
        if var text = inputSearchBarText.value, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            text = text.lowercased()
            searchKeyword = text
            
            
            if city.city_name.contains(text) || city.city_english_name.lowercased().contains(text) || city.city_explain.contains(text) {
                outputFilteredCities.value.append(city)
            }
        } else {
            outputFilteredCities.value.append(city)
        }
    }
    
    private func filteredCitiesWithSearchKeyword(text: String) {
        
        if text.isEmpty {
            self.setupFilteredCities(num: self.inputSegmentTapped.value ?? 0)
            
            self.outputCities.value = self.outputFilteredCities.value
            return
        }
        
        var cityArray: [City] = []
        
        for city in outputFilteredCities.value {
            if city.city_name.contains(text) || city.city_english_name.lowercased().contains(text) || city.city_explain.contains(text) {
                cityArray.append(city)
            }
        }
        
        self.outputCities.value = cityArray
    }
    
    
}
