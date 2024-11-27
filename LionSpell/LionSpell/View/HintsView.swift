//
//  HintsView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/16/24.
//

import SwiftUI

struct HintsView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack {
                Form {
                    Section(header: Text("Summary")) {
                        HStack {
                            Text("Words left to find")
                            Spacer()
                            Text("\(remainingWordCount)")
                                .bold()
                        }
                        HStack {
                            Text("Total Achievable Points")
                            Spacer()
                            Text("\(gameManager.problem.totalPoints)")
                                .bold()
                        }
                        HStack {
                            Text("Total Panagrams")
                            Spacer()
                            Text("\(gameManager.problem.panagramNum)")
                                .bold()
                        }
                    }
                    
                    ForEach(gameManager.wordLengthHint.keys.sorted(), id: \.self) { length in
                        Section(header: Text("Words of Length \(length)")) {
                            ForEach(gameManager.wordLengthHint[length]?.keys.sorted() ?? [], id: \.self) { letter in
                                HStack {
                                    Text("\(String(letter))")
                                    Spacer()
                                    Text("\(gameManager.wordLengthHint[length]?[letter] ?? 0)")
                                }
                            }
                        }
                    }
                    //Spacer()
                    Section {
                        Button(action: {
                            gameManager.showHints = false
                        }, label: {
                            Text("Close")
                        })
                    }
                }
            
        }
    }
    
    private var remainingWordCount: Int {
        let totalWords = gameManager.problem.correctWordSet
        let foundWords = Set(gameManager.submittedWords)
        return totalWords.subtracting(foundWords).count
    }
}

#Preview {
    HintsView()
        .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}
