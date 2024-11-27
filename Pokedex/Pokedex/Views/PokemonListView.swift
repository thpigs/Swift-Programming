//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/27/24.
//

import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var manager: Manager
    //turn this into enum in models
    @State var filterChoice: filterOptions = .id
    //@State var typeFilter: PokemonType = .all
    @State var ascending = true
    var body: some View {
        NavigationStack {
            HStack{
                HStack {
                    
                    Picker("Filter", selection: $manager.typeFilter) {
                        ForEach(PokemonType.allCases, id:\.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    /*.onChange(of: manager.typeFilter) { choice in
                        manager.filterPokedex2(filterChoice: choice)

                    }*/
                    .padding(.horizontal)
                    
                    /*Button(action: {
                        manager.reversePokedex()
                        ascending.toggle()
                    }, label: {
                        Image(systemName: ascending ? "arrow.up" : "arrow.down")
                    })
                    .padding(.leading, -20)
                     */
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                 
                
                
                Spacer()
                Text("Pokedex")
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            List(manager.filterDex) { pokemon in
                NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                    PokemonPreview(pokemon: pokemon)
                }
            }
            
            /*
            // Old list view for Pokedex I
            //Add sections
            List {
                if let pokedex = manager.pokedex {
                    
                    ForEach(pokedex) { pokemon in
                        NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                            PokemonPreview(pokemon: pokemon)
                        }
                    }
                }
            }
             */
        }
        .padding(.bottom, 15)
    }
}

#Preview {
    PokemonListView()
        .environmentObject(Manager())
}
