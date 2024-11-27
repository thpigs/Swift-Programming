//
//  PuzzleButtonsView.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/23/24.
//

import SwiftUI

struct PuzzleButtonsView: View {
    @EnvironmentObject var gameManager: GameManager
    let range: (Int, Int)
    
    var body: some View {
        VStack{
            ForEach(range.0...range.1, id:\.self) { num in
                Button(action: {
                    gameManager.changePuzzle(num: num)
                }) {
                    Image("Board\(num)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                }
            }
        }
        .padding()
    }
}

#Preview {
    PuzzleButtonsView(range: (0,7))
        .environmentObject(GameManager())

}
