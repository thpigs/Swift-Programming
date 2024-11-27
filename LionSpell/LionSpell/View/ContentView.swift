//
//  ContentView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        ZStack {
            Color.mint
            VStack {
                TitleView()
                    .padding(.vertical, 50)
                Spacer()
                WordDisplayView()
                Spacer()
                BuildingWordView()
                    .padding(.vertical, 50)
                LetterButtonsView()
                DeleteSubmitButtonView()
                ScoreDisplayView(Score: "00")
                Spacer()
                MenuButtonsView()
                    .padding()
            }
            if gameManager.showSettings {
                PreferencesView()
            }
            if gameManager.showHints {
                HintsView()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        .environmentObject(GameManager(problem: Problem(letterAmount: 5), preferences: Preferences(numberOfLetters: .five, language: .english)))
}
