//
//  SwiftUIView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct LetterButtonsView: View {
    //var word: String
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        GeometryReader { geom in
            ZStack {
                ForEach(0..<gameManager.preferences.numberOfLetters.rawValue, id: \.self) { index in
                    Button(action: {
                        gameManager.addLetter(letter: gameManager.letterChoices[index])
                    }, label: {
                        Text(String(gameManager.letterChoices[index]))
                            .bold()
                        //.font(.system(size: ))
                            .padding()
                        // Font Color
                            .foregroundStyle(Color.red)
                            .background(index == 0 ? Color.yellow : Color.gray)
                        
                    })
                    
                    .clipShape(CustomShapes(letterAmount: gameManager.preferences.numberOfLetters.rawValue))
                    .contentShape(CustomShapes(letterAmount: gameManager.preferences.numberOfLetters.rawValue))
                    .aspectRatio(1, contentMode: .fit)
                    .scaleEffect(2.5)
                    .position(self.calculatePosition(index: index, size: geom.size))
                    
                }
            }
        }
        //.frame(width: 300, height: 300)
    }
    
    // Prob not working correctly because you manually drew all shapes instead of figuring out an algo to take in a number of sides and draw it for you.
    func calculatePosition(index: Int, size: CGSize) -> CGPoint {
        let radius: CGFloat = CGFloat(12 * gameManager.preferences.numberOfLetters.rawValue)
        
        let midX = size.width/2
        let midY = size.height/2
        if index == 0 {
            return CGPoint(x:midX, y:midY)
        }
        
        let offsetAngle: CGFloat = 45 * (.pi / 180)
        
        let angle = (2 * .pi / (CGFloat(gameManager.preferences.numberOfLetters.rawValue - 1))) * CGFloat(index-1) - offsetAngle

        let xOffset = radius * cos(angle) + midX
        let yOffset = radius * sin(angle) + midY

        return CGPoint(x: xOffset, y: yOffset)
    }
}

#Preview {
    LetterButtonsView()
        .environmentObject(GameManager(problem: Problem(letterAmount: 5),preferences: Preferences(numberOfLetters: .five, language: .english)))
}
