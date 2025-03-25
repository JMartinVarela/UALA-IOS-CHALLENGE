//
//  City.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 24/03/2025.
//

struct City {
    let country: String
    let name: String
    let id: Int
    let coordinate: Coordinate
}

struct Coordinate {
    let lon: Double
    let lat: Double
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}
