//
//  TrieTests.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 27/03/2025.
//

import XCTest
@testable import UalaChallenge

final class TrieTests: XCTestCase {
    
    var trie: Trie!

    override func setUp() {
        super.setUp()
        trie = Trie()
        
        // Insert test data into the Trie
        let cities = [
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
        for city in cities {
            trie.insert(word: "\(city.name), \(city.country)", city: city)
        }
    }

    override func tearDown() {
        trie = nil
        super.tearDown()
    }

    func testSearchWithMatchingPrefix() {
        // Given
        let expectedResult = [City(country: "RU", name: "Novinki", id: 519188, coordinate: .init(lon: 37.666668, lat: 55.683334))]
        
        // When
        let result = trie.search(withPrefix: "Nov")
        
        // Then
        XCTAssertEqual(result, expectedResult, "Nov should return Novinki")
    }
    
    func testSearchWithMultipleMatches() {
        // Given
        let expectedResult = [
            City(country: "UA", name: "Hurzuf", id: 707860, coordinate: .init(lon: 34.283333, lat: 44.549999)),
            City(country: "UA", name: "Holubynka", id: 708546, coordinate: .init(lon: 33.900002, lat: 44.599998))
        ]
        
        // When
        let result = trie.search(withPrefix: "H")
        
        // Then
        XCTAssertEqual(result, expectedResult, "H should return Hurzuf and Holubynka")
    }

    func testSearchWithExactMatch() {
        // Given
        let expectedResult = [City(country: "ZA", name: "Botswana", id: 1016666, coordinate: .init(lon: 30.533331, lat: -24.33333))]
        
        //When
        let result = trie.search(withPrefix: "Botswana, ZA")
        
        // Then
        XCTAssertEqual(result, expectedResult, "Exact match should return Botswana")
    }

    func testSearchWithNoMatches() {
        // When
        let result = trie.search(withPrefix: "K")
        
        // Then
        XCTAssertTrue(result.isEmpty, "K should return an empty list")
    }

    func testSearchWithEmptyPrefix() {
        // When
        let result = trie.search(withPrefix: "")
        
        // Then
        XCTAssertFalse(result.isEmpty, "Empty prefix should return all cities")
    }

    func testSearchWithCaseInsensitivity() {
        // Given
        let expectedResult = [City(country: "CN", name: "Lhasa", id: 1280737, coordinate: .init(lon: 91.099998, lat: 29.65))]
        
        // When
        let result = trie.search(withPrefix: "LHA")
        
        // Then
        XCTAssertEqual(result, expectedResult, "Trie is case-insensitive, so 'LHA' should return Lhasa")
    }
}
