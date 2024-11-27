//
//  ShapesView.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/23/24.
//

import SwiftUI

struct Grid: Shape {
    var n: Int
    var m: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // X-axis lines
        for line in stride(from: 0, to: n+1, by: 1) {
            // Calculates the height of the line based on the number line it is
            let y = rect.minY + CGFloat(line) * rect.height/CGFloat(n)
            path.move(to: CGPoint(x: rect.minX, y: y))
            path.addLine(to: CGPoint(x: rect.maxX, y: y))
            //print(y)
        }
        // Y-axis lines
        for line in stride(from: 0, to: m + 1, by: 1) {
            // Calculates the x position of the line based on what number line it is
            let x = rect.minX + CGFloat(line) * rect.width/CGFloat(m)
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
            //print(x)
        }
        return path
    }
}


struct Pentomino: Shape{
    var pieceOutline: PentominoOutline
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var first = true
        let gridSize: Int = 14 // 14x14
        for point in pieceOutline.outline {
            let cellWidth = rect.width / CGFloat(gridSize)
            let cellHeight = rect.height / CGFloat(gridSize) //CGFloat(pieceOutline.size.height)
            
            let x = rect.minX + CGFloat(point.x) * cellWidth
            let y = rect.minY + CGFloat(point.y) * cellHeight
            
            if first {
                path.move(to: CGPoint(x: x, y: y))
                first = false
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}
 

struct Puzzle: Shape {
    //@EnvironmentObject var gameManager: GameManager
    let gridSize: Int = 14 // 14x14
    var puzzleOutline: PuzzleOutline

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cellWidth = rect.width / CGFloat(gridSize)
        let cellHeight = rect.height / CGFloat(gridSize)
        let xScale = cellWidth// / CGFloat(puzzleOutline.size.width)
        //print("Cell width: \(cellWidth), CGFloat(gridSize): \(CGFloat(gridSize)), CGFloat(puzzleOutline.size.width): \(CGFloat(puzzleOutline.size.width))")
        let yScale = cellHeight// / CGFloat(puzzleOutline.size.height)
        /*
        guard let puzzleOutline = gameManager.currPuzzle else {
            return path
        }
         */

        for outline in puzzleOutline.outlines {
            var path2 = Path()
            var first = true
            
            for point in outline {
                let offSetX = findOffset(gridSize: CGFloat(gridSize), length: CGFloat(puzzleOutline.size.width))
                let offSetY = findOffset(gridSize: CGFloat(gridSize), length: CGFloat(puzzleOutline.size.height))
                
                //print("offsetX: \(offSetX), offSetY: \(offSetY)")
                let x = rect.minX + CGFloat(point.x) * xScale + offSetX * cellWidth
                let y = rect.minY + CGFloat(point.y) * yScale + offSetY * cellHeight
                //print("x: \(x), y: \(y)")
                if first {
                    path2.move(to: CGPoint(x: x, y: y))
                    first = false
                }
                else {
                    path2.addLine(to: CGPoint(x: x, y: y))
                }
            }
            path.addPath(path2)
        }
        return path
    }
    
    // Calculates offset by finding remaining grid space after puzzle is placed and centering from there.
    func findOffset(gridSize: CGFloat, length: CGFloat) -> CGFloat {
        let offset = CGFloat(Int((gridSize - length) / 2))
        return offset
    }
}

struct Puzzle_Previews: PreviewProvider {
    static var previews: some View {
        let gameManager = GameManager()
        
        ZStack {
            Grid(n: 14, m: 14)
                .stroke(Color.black,lineWidth: 1)
                .frame(width: 900, height: 900)
            Puzzle(puzzleOutline: gameManager.puzzleOutlines[1])
                .fill(Color.black.opacity(0.5), style: FillStyle(eoFill: true))
                    .frame(width: 900, height: 900)
                    //.offset(x: 450, y: 450)

        }
        
        
        Pentomino(pieceOutline: gameManager.pieces[0].outline)
            .stroke(Color.black,lineWidth: 1)
            .frame(width: 900, height: 900)
            

    }
}
/*
 #Preview {
 Puzzle(puzzleOutline: gameManager.puzzleOutlines[0])
 
 /*
  Grid(n: 15, m: 15)
  .stroke(Color.black,lineWidth: 1)
  .frame(width: 900, height: 900)
  */
 
 }
 */
