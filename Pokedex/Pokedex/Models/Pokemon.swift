//
//  Pokemon.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/27/24.
//

import Foundation

struct Pokemon: Codable,  Hashable, Identifiable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let height: Double
    let weight: Double
    let weaknesses: [PokemonType]
    let prev_evolution: [Int]?
    let next_evolution: [Int]?
    var captured: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case height
        case weight
        case weaknesses
        case prev_evolution
        case next_evolution
        case captured
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        types = try container.decode([PokemonType].self, forKey: .types)
        height = try container.decode(Double.self, forKey: .height)
        weight = try container.decode(Double.self, forKey: .weight)
        weaknesses = try container.decode([PokemonType].self, forKey: .weaknesses)
        prev_evolution = try container.decodeIfPresent([Int].self, forKey: .prev_evolution)
        next_evolution = try container.decodeIfPresent([Int].self, forKey: .next_evolution)
        
        // Use decodeIfPresent to provide a default value of false if "captured" is missing
        captured = try container.decodeIfPresent(Bool.self, forKey: .captured) ?? false
    }
    
    init(id: Int, name: String, types: [PokemonType], height: Double, weight: Double, weaknesses: [PokemonType], prev_evolution: [Int]?, next_evolution: [Int]?, captured: Bool = false) {
            self.id = id
            self.name = name
            self.types = types
            self.height = height
            self.weight = weight
            self.weaknesses = weaknesses
            self.prev_evolution = prev_evolution
            self.next_evolution = next_evolution
            self.captured = captured
        }
}
