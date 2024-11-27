//
//  PentominoView.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/24/24.
//

import SwiftUI

struct PentominoView: View {
    let outline: PentominoOutline
    let color: Color
    
    var body: some View {
        ZStack {
            let block = Pentomino(pieceOutline: outline)
            let block2 = Pentomino(pieceOutline: outline)

            block
                .fill(color)
                //.frame(width: 600, height: 600)
            block2
                .stroke(Color.black, lineWidth: 1)
                //.frame(width: 600, height: 600)
            
            Grid(n: 14, m: 14) // outline.size.heigh/width
                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                //.frame(width: 600, height: 600)
                .clipShape(block)
            
            
        }
        
    }
}

struct PentominoPreview: PreviewProvider {
    static var previews: some View {
        let gameManager = GameManager()
        
        PentominoView(outline: gameManager.pieces[0].outline, color: Color.blue)
            

    }
}
