//
//  URLDataCollector.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 25/03/2025.
//

import Foundation

final class URLDataCollector: DataCollector {
    func getData<T: Decodable>(type: T.Type, url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw DataCollectorError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw DataCollectorError.serverError
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let result = try jsonDecoder.decode(T.self, from: data)
            return result
        } catch {
            throw DataCollectorError.decodingError
        }
    }
}
