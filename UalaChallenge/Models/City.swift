//
//  City.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 24/03/2025.
//

struct City: Codable {
    let country: String
    let name: String
    let id: Int
    let coordinate: Coordinate
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}

struct FavoriteCities: Codable {
    let items: [City]
}
