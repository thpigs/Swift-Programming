//
//  BuildingWordView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct BuildingWordView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        Text(gameManager.wordBuilder)
            .bold()
            .font(.system(size:24))
    }
}

#Preview {
    BuildingWordView()
        .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}
