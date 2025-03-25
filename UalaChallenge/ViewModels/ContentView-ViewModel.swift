//
//  ContentView-ViewModel.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 24/03/2025.
//

import Observation

extension ContentView {
    @Observable
    final class ViewModel {
        // MARK: - Properties
        @ObservationIgnored private let dataManager: DataManager
        
        private(set) var cities: [City] = []
        
        var citySelected: City?
        
        // MARK: - Initializers
        init(dataManager: DataManager = CitiesDataManager()) {
            self.dataManager = dataManager
        }
        
        // MARK: - Functions
        func fetchCities() async {
            let response = await dataManager.fetchCities()
            
            await MainActor.run {
                switch response {
                case .success(let cities):
                    self.cities = cities.map { City(country: $0.country, name: $0.name, id: $0.id, coordinate: $0.coordinate) }
                    citySelected = self.cities.first
                case .failure:
                    print("Error fetching data")
                    // Improve error handling
                }
            }
        }
    }
}
