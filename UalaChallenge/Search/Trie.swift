//
//  Trie.swift
//  UalaChallenge
//
//  Created by Juan Martin Varela on 27/03/2025.
//

/// TrieNode for storing characters and cities
class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isWord: Bool = false
    var city: City?
}

/// Trie structure for efficient prefix searching
/// Standard List Filtering ( O(n) ) --> Each search requires scanning all elements (n)
/// Trie Lookup ( O(p) ) --> It traverses the tree only up to the query length (p), making it much faster for large datasets
class Trie {
    private let root = TrieNode()
    
    /// Insert a city into the Trie
    func insert(word: String, city: City) {
        var node = root
        // Search is case-insensitive
        let lowercasedWord = word.lowercased()
        
        for char in lowercasedWord {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.isWord = true
        node.city = city
    }
    
    /// Get all cities with a given prefix
    func search(withPrefix prefix: String) -> [City] {
        var node = root
        // Search is case-insensitive
        let lowercasedPrefix = prefix.lowercased()
        
        for char in lowercasedPrefix {
            guard let nextNode = node.children[char] else {
                return [] // No matches found
            }
            node = nextNode
        }
        return collectCities(from: node)
    }
    
    /// Helper function to collect all cities from a given TrieNode
    private func collectCities(from node: TrieNode) -> [City] {
        var results: [City] = []
        if node.isWord {
            guard let city = node.city else { return results }
            results.append(city)
        }
        
        for (_, nextNode) in node.children {
            results.append(contentsOf: collectCities(from: nextNode))
        }
        
        return results
    }
}
