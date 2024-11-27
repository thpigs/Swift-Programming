//
//  MenuButtonsView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct MenuButtonsView: View {
    @EnvironmentObject var gameManager: GameManager
    let menuButtonNames = ["Shuffle", "New Game", "Hint", "Settings"]
    var body: some View {
        HStack{
            ForEach(0..<menuButtonNames.count, id:\.self) { num in
                Button(action: {
                    self.performAction(for: num)
                }, label: {
                    Text(menuButtonNames[num])
                        .bold()
                        .padding()
                        .foregroundStyle(Color.red)
                        .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(Color.blue))
                })
            }
        }
    }
    
    private func performAction(for index: Int) {
        switch index {
        case 0:
            gameManager.shuffle()
        case 1:
            gameManager.newGame()
        case 2:
            gameManager.hint()
        case 3:
            gameManager.settings()
        default:
            break
        }
    }
}
    
#Preview {
    MenuButtonsView()
        .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}

