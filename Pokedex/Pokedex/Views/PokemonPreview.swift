//
//  PokemonPreview.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/27/24.
//

import SwiftUI

struct PokemonPreview: View {
    @EnvironmentObject var manager: Manager
    let pokemon: Pokemon
    var body: some View {
        HStack {
            //Text(String(format: "%03d", pokemon.id))
              //  .padding()
            //Spacer()
            VStack {
                let id = String(format: "%03d", pokemon.id)
                Text(pokemon.name)
                    .bold()
                Text(String(format: "%03d", pokemon.id))
                //Spacer(
                //Spacer()
                Image(String(format: "%03d", pokemon.id))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(manager.getPokemonColor(type: pokemon.types[0]))
                    .cornerRadius(10)
                    .padding(.horizontal)
                Text(pokemon.captured ? "Captured" : "Released")
                    .foregroundColor(pokemon.captured ? Color.red : Color.blue)
            }
                
            
        }
    }
    
    
}

#Preview {
    let manager = Manager()
    
    if let pokedex = manager.pokedex {
        return PokemonPreview(pokemon: pokedex[0])
            .environmentObject(Manager())
    }
    else {
        return Text("preview fail")
    }
}

