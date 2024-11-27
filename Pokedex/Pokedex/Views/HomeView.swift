//
//  HomeView.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 11/5/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: Manager
    //turn this into enum in models
    @State var filterChoice: filterOptions = .id
    @State var ascending = true
    var body: some View {
        NavigationStack {
            HStack{

                Spacer()
                Text("Pokedex")
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            ScrollView {
                if let capturedPokemon = manager.getCapturedPokemon() {
                    if (!capturedPokemon.isEmpty) {
                        VStack(alignment: .leading) {
                            //Spacer()
                            Text("Captured Pokemon")
                                .font(.headline)
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(capturedPokemon) { pokemon in
                                        NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                                            PokemonPreview(pokemon: pokemon)
                                        }
                                        .padding(.bottom, 50)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom)
                    }
                    
                }
                
                if let pokedex = manager.pokedex {
                    let pokeTypes = Dictionary(grouping: pokedex, by: { $0.types.first! })
                    ForEach(pokeTypes.keys.sorted(by: {$0.rawValue < $1.rawValue}), id: \.self) { type in
                        if let pokemonTypeList = pokeTypes[type] {
                            VStack {
                                Text(type.rawValue.capitalized)
                                    .font(.headline)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(pokemonTypeList) { pokemon in
                                            NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                                                PokemonPreview(pokemon: pokemon)
                                            }
                                            .padding(.bottom, 50)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom, 15)
    }
}


#Preview {
    HomeView()
        .environmentObject(Manager())
}
