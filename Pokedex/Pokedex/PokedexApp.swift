//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/27/24.
//

import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Manager())
        }
    }
}
