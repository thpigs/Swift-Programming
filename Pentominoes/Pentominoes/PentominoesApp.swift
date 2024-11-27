//
//  PentominoesApp.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/23/24.
//

import SwiftUI

@main
struct PentominoesApp: App {
    @StateObject private var gameManager = GameManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
        }
        
    }
}
