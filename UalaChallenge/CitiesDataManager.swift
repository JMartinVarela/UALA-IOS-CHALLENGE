//
//  CitiesDataManager.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 25/03/2025.
//

import Foundation

final class CitiesDataManager: DataManager {
    // MARK: - Properties
    private let dataCollector: DataCollector
    private let url = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    
    // MARK: - Initializers
    init(dataCollector: DataCollector = URLDataCollector()) {
        self.dataCollector = dataCollector
    }
    
    // MARK: - Functions
    func fetchCities() async -> Result<[CityResponse], Error> {
        do {
            let response = try await dataCollector.getData(type: [CityResponse].self, url: url)
            let sortedList = response.sorted {
                ($0.name, $0.country) < ($1.name, $1.country)
            }
            return .success(sortedList)
        } catch {
            return .failure(error)
        }
    }
    
    func saveFavoriteCities(_ favorites: Set<Int>) {
        UserDefaults.standard.set(Array(favorites), forKey: "favoriteCities")
    }
    
    func loadFavoriteCities() -> Set<Int> {
        let savedCities = UserDefaults.standard.array(forKey: "favoriteCities") as? [Int] ?? []
        return Set(savedCities)
    }
}
