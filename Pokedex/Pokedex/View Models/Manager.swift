//
//  Manager.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/27/24.
//

import Foundation
import SwiftUI
class Manager : ObservableObject {
    @Published var pokedex: [Pokemon]?
    //@Published var filterDex: [Pokemon] = []
    @Published var typeFilter: PokemonType = .all

    init() {
        if let temp = JSONParser().readJson(file: "UserData") {
            pokedex = temp
        }
        else {
            pokedex = JSONParser().readJson(file: "pokedex")
        }
        //print(self.pokedex)
        filterPokedex(filterChoice: .types)
    }
    
    var filterDex: [Pokemon] {
        guard let dex = pokedex else { return [] }
        
        if typeFilter == .all {
            return dex
        } else {
            return dex.filter { $0.types.contains(typeFilter) }
        }
    }
    
    func getPokemonColor(type: PokemonType) -> Color {
        return Color(pokemonType: type)
    }
    
    func getCapturedPokemon() -> [Pokemon]? {
        return pokedex?.filter { $0.captured }
    }
    
    func getPokemonByID(id: Int) -> Pokemon? {
        return pokedex?.first(where: { $0.id == id})
    }
    
    func getPokemonByName(name: String) -> Pokemon? {
        return pokedex?.first(where: { $0.name == name })
    }
    
    func toggleCapture(pokemon: Pokemon) {
        if var dex = self.pokedex {
            if let index = dex.firstIndex(where: { $0.id == pokemon.id }) {
                dex[index].captured.toggle()
            }
            self.pokedex = dex
        }
        
    }
    
    // Use keypaths?
    func filterPokedex(filterChoice: filterOptions) {
        //print(pokedex)
        if var dex = self.pokedex {
            switch filterChoice {
            case .id:
                let temp = dex.sorted { $0.id < $1.id}
                self.pokedex = temp
            case .types:
                let temp = dex.sorted { $0.types[0].rawValue < $1.types[0].rawValue}
                self.pokedex = temp
            case .height:
                let temp = dex.sorted { $0.height < $1.height}
                self.pokedex = temp
            case .weight:
                let temp = dex.sorted { $0.weight < $1.weight}
                self.pokedex = temp
            }
        }
        //print("IN FILTER POKEDEX: \(self.pokedex)")
    }
    /*
    func filterPokedex2(filterChoice: PokemonType) {
        if let dex = pokedex {
            if filterChoice == .all {
                filterDex = dex
            } else {
                filterDex = dex.filter { $0[keyPath: \.types].contains(filterChoice) }
            }
        }
        
    }
     */
    
    func reversePokedex() {
        if var dex = self.pokedex {
            dex.reverse()
            self.pokedex = dex
        }
    }
    
}
