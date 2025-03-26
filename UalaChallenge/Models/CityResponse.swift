//
//  CityResponse.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 25/03/2025.
//

struct CityResponse: Decodable {
    let country: String
    let name: String
    let id: Int
    let coordinate: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coordinate = "coord"
    }
}
