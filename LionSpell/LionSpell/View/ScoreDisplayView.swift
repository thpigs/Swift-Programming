//
//  ScoreDisplayView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct ScoreDisplayView: View {
    @EnvironmentObject var gameManager: GameManager
    var Score: String
    var body: some View {
        Text("Score:\n\(gameManager.score)")
            .bold()
            .font(.system(size:32))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    ScoreDisplayView(Score: "0")
        .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}
