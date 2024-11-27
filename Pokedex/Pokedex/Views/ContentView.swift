//
//  ContentView.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/27/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        NavigationStack {
            TabView {
                // Tab for HomeView
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                // Tab for PokemonListView
                PokemonListView()
                    .tabItem {
                        Label("List", systemImage: "list.bullet")
                    }
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        
    }
}

#Preview {
    ContentView()
        .environmentObject(Manager())
}
