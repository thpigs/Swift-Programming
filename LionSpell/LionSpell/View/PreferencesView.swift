//
//  PreferencesView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/16/24.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack {
            Form {
                Picker("Select a Language", selection: $gameManager.preferences.language) {
                    ForEach(Language.allCases) { choice in
                        Text(choice.rawValue).tag(choice)
                    }
                }
                
                Picker("Letter Amount", selection: $gameManager.preferences.numberOfLetters) {
                    ForEach(NumberOfLetters.allCases) { choice in
                        Text("\(choice.rawValue)").tag(choice)
                        
                    }
                }
                Spacer()
                
                Section {
                    Button(action: {
                        gameManager.showSettings = false
                        gameManager.newGame()
                    }, label: {
                        Text("Save")
                    })
                    
                }
            }
        }
    }
}

#Preview {
    PreferencesView()
        .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}
