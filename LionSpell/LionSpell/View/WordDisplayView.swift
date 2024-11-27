//
//  SubmittedWords.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct WordDisplayView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ScrollView(.horizontal, content:  {
            HStack {
                ForEach(gameManager.submittedWords, id: \.self) {word in
                    Text(word)
                        .bold()
                }
            }
            
            
        })
    }
}


#Preview {
    WordDisplayView()
                .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}
