//
//  ContentView.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        VStack {
                HStack {
                    PuzzleButtonsView(range: (0,3))
                    
                    ZStack {
                        let width: CGFloat = 600
                        let height: CGFloat = 600
                        
                        Grid(n: gameManager.gridSize.0, m: gameManager.gridSize.1)
                            .stroke(Color.black)
                            .frame(width: width, height: height)
                        Puzzle(puzzleOutline: gameManager.currPuzzle ?? gameManager.puzzleOutlines[0])
                            .fill(Color.black.opacity(0.5), style: FillStyle(eoFill: true))
                            .frame(width: width, height: height)
                        
                    }
                    PuzzleButtonsView(range: (4,7))
                }
            VStack {
                ForEach(0...2, id: \.self) { i in
                    let lowerB = i*4
                    let upperB = i*4 + 3
                    HStack {
                        ForEach(lowerB...upperB, id:\.self) { num in
                            PieceView(piece: $gameManager.pieces[num])
                            
                        }
                        
                    }
                }
            }
            .offset(x: 350, y: 300)
            MenuButtonsView()
                
                
            }
    }
        
}


#Preview {
    ContentView()
        .environmentObject(GameManager())
}
