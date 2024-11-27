//
//  LionSpellApp.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI
    
@main
struct LionSpellApp: App {
    @State private var gameManager = GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english))
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
        }
    }
}
