//
//  DeleteSubmitButtonView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct DeleteSubmitButtonView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        HStack {
            Button(action: {
                gameManager.deleteLetter()
            }, label: {
                Text("Delete")
                    .bold()
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(gameManager.emptyAnswer ? Color.gray : Color.red))
                    
            })
            .disabled(gameManager.emptyAnswer)
            Spacer()
            Button(action: {
                gameManager.submit()
            }, label: {
                Text("Submit")
                    .bold()
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(gameManager.isCorrect && !gameManager.submittedWords.contains(gameManager.wordBuilder) ? Color.green : Color.gray))
                    
            })
            .disabled(!gameManager.isCorrect || gameManager.submittedWords.contains(gameManager.wordBuilder))
        }
    }
}

#Preview {
    DeleteSubmitButtonView()
        .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}
    
