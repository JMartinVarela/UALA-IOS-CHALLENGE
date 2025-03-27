//
//  ContentView-ViewModel.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 24/03/2025.
//

import Observation
import SwiftUI


@Observable
final class CitiesViewModel {
    // MARK: - Properties
    @ObservationIgnored
    private let dataManager: DataManager
    @ObservationIgnored
    private let trie = Trie()
    
    private(set) var cities: [City] = []
    private(set) var loadingCitiesState: LoadingState = .loading
    
    // Cities stored by id
    var favoriteCities: [City] = []
    
    var filterOnlyFavorites: Bool = false
    
    @ObservationIgnored
    private(set) var skeletonCities: [City] = [
        City(country: "UA", name: "Hurzuf", id: 707860, coordinate: .init(lon: 34.283333, lat: 44.549999)),
        City(country: "RU", name: "Novinki", id: 519188, coordinate: .init(lon: 37.666668, lat: 55.683334)),
        City(country: "UA", name: "Holubynka", id: 708546, coordinate: .init(lon: 33.900002, lat: 44.599998)),
        City(country: "VE", name: "Merida", id: 3632308, coordinate: .init(lon: -71.144997, lat: 8.598333)),
        City(country: "CN", name: "Lhasa", id: 1280737, coordinate: .init(lon: 91.099998, lat: 29.65)),
        City(country: "TR", name: "Istanbul", id: 745042, coordinate: .init(lon: 28.983311, lat: 41.03508)),
        City(country: "RU", name: "Verkhneye Shchekotikhino", id: 475279, coordinate: .init(lon: 36.133331, lat: 53)),
        City(country: "ZA", name: "Botswana", id: 1016666, coordinate: .init(lon: 30.533331, lat: -24.33333)),
        City(country: "AR", name: "El Destierro", id: 3858204, coordinate: .init(lon: -62.47662, lat: -24.1)),
        City(country: "CN", name: "Zhengzhou", id: 1784658, coordinate: .init(lon: 113.648613, lat: 34.757778))
    ]
    
    var citySelected: City?
    
    var searchText: String = ""
    var showSearchBar: Bool = false
    
    var filteredCities: [City] {
        guard !searchText.isEmpty else {
            return cities
        }
        
        if filterOnlyFavorites {
            return favoriteCities.filter {
                "\($0.name), \($0.country)".lowercased().hasPrefix(self.searchText.lowercased())
            }.sorted(by: { ($0.name, $0.country) < ($1.name, $1.country) } )
        }
        
        return trie.search(withPrefix: searchText.lowercased())
    }
    
    // MARK: - Initializers
    init(dataManager: DataManager = CitiesDataManager()) {
        self.dataManager = dataManager
    }
    
    // MARK: - Functions
    func fetchCities() async {
        await MainActor.run {
            loadingCitiesState = .loading
            showSearchBar = false
        }
        
        let response = await dataManager.fetchCities()
        
        await MainActor.run {
            switch response {
            case .success(let cities):
                self.cities = cities.map { City(country: $0.country, name: $0.name, id: $0.id, coordinate: $0.coordinate) }
                preprocessData() // prepare cities data for future searches
                favoriteCities = dataManager.loadFavoriteCities()
                citySelected = self.cities.first
                loadingCitiesState = .loaded
            case .failure:
                loadingCitiesState = .error
            }
        }
    }
    
    func isFavorite(_ city: City) -> Bool {
        return favoriteCities.contains(city)
    }
    
    func toogleFavoriteCity(_ city: City) {
        if favoriteCities.contains(city) {
            favoriteCities.removeAll { $0 == city }
        } else {
            favoriteCities.append(city)
        }
        
        dataManager.saveFavoriteCities(favoriteCities)
    }
}

private extension CitiesViewModel {
    func preprocessData() {
        Task {
            cities.forEach {
                trie.insert(word: "\($0.name), \($0.country)", city: $0) // Preprocessing: Insert all cities into the Trie for fast searches
            }
            
            await MainActor.run {
                withAnimation {
                    showSearchBar = true
                }
            }
        }
    }
}


