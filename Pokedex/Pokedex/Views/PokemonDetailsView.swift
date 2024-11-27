//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/27/24.
//

import SwiftUI

struct PokemonDetailsView: View {
    @EnvironmentObject var manager: Manager
    var pokemon: Pokemon
    @State var captureFlag = false
    let typeKeypaths: [KeyPath<Pokemon, [PokemonType]>] = [\Pokemon.types, \Pokemon.weaknesses]
    let heightWeightKeypaths = [\Pokemon.height, \Pokemon.weight]
    let scrollViewHeadings = ["Types", "Weaknesses"]
    let heightWeightHeadings = ["Height", "Weight"]
    let units = ["m", "kg"]

    var body: some View {
        ScrollView(.vertical) {
            // Image
            Image(String(format: "%03d", pokemon.id))
                .resizable()
                .frame(maxWidth: .infinity, alignment: .top)
                .aspectRatio(1, contentMode: .fit)
                .background(manager.getPokemonColor(type: pokemon.types[0]))
                .cornerRadius(10)
                .padding()
            
            // Height and Weight
            HStack {
                ForEach(0..<heightWeightKeypaths.count, id: \.self) { i in
                    Spacer()
                    VStack {
                        Text(heightWeightHeadings[i])
                            .bold()

                        Text("\(String(format: "%.3f", pokemon[keyPath: heightWeightKeypaths[i]])) \(units[i])")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                }
            }
                
            //Types and Weaknesses
            VStack {
                ForEach(0..<typeKeypaths.count, id: \.self) { i in
                    Text(scrollViewHeadings[i])
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(pokemon[keyPath: typeKeypaths[i]], id: \.self) { type in
                                Text(type.rawValue)
                                    .padding(5)
                                    .background(manager.getPokemonColor(type: type))
                                    .cornerRadius(15)
                                    .foregroundColor(Color.white)
                                    //.frame(maxWidth: 200, alignment: .center)
                            }
                        }
                        .padding()
                    }
                }
            }
                
            // Capture button
            Button(action: {
                manager.toggleCapture(pokemon: pokemon)
                captureFlag.toggle()
                if let mon = manager.getPokemonByName(name: pokemon.name) {
                    print("Toggling capture for \(mon.name): \(mon.captured)")
                }
                if let dex = manager.pokedex {
                    JSONParser().saveUserData(pokedex: dex, file: "UserData")

                }
                
            }, label: {
                if let mon = manager.getPokemonByName(name: pokemon.name) {
                    Text(mon.captured ? "Capture" : "Release")
                    Image(systemName: mon.captured ? "circle.fill" : "circle")
                }
                
            })
            
            // Next and Prev Evo cards
            HStack {
                if let prevEvos = pokemon.prev_evolution, let lastID = prevEvos.last {
                    if let prevMon = manager.getPokemonByID(id: lastID) {
                        NavigationLink(destination: PokemonDetailsView(pokemon: prevMon)) {
                            PokemonPreview(pokemon: prevMon)
                        }
                    }
                }
                Spacer()
                if let nextEvos = pokemon.next_evolution, let firstID = nextEvos.first {
                    if let nextMon = manager.getPokemonByID(id: firstID) {
                        NavigationLink(destination: PokemonDetailsView(pokemon: nextMon)) {
                            PokemonPreview(pokemon: nextMon)
                        }
                    }
                }

                
            }
        }
        .navigationTitle("\(pokemon.name)")
    }
}

#Preview {
    let manager = Manager()
    
    if let pokedex = manager.pokedex {
        return PokemonDetailsView(pokemon: pokedex[1])
            .environmentObject(Manager())
    }
    else {
        return Text("preview fail")
    }
}
