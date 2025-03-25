//
//  Protocols.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 25/03/2025.
//

import Foundation

protocol DataCollector {
    func getData<T: Decodable>(type: T.Type, url: String) async throws -> T
}

protocol DataManager {
    func fetchCities() async -> Result<[CityResponse], Error>
}

enum DataCollectorError: Error {
    case badURL
    case serverError
    case decodingError
}

enum LoadingState {
    case loading
    case loaded
    case error
}
