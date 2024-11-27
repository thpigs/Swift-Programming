//
//  PieceView.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/24/24.
//

import SwiftUI

struct PieceView: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var piece: Piece
    @State var offset: CGSize = .zero
    @State var startPos: CGPoint = .zero
    @State var isDragging = false
    @State var scaleX: CGFloat = 600
    @State var scaleY: CGFloat = 600
    @State var rotations: threeDimRotations = threeDimRotations()
    
    var body: some View {
        PentominoView(outline: piece.outline, color: Color.blue)
                    .frame(width: scaleX, height: scaleY)
                    .rotation3DEffect(.degrees(Double(rotations.xRot * 180)), axis: (x: 1, y: 0, z: 0), anchor: UnitPoint(x: 0.105, y: 0.105))
                    .rotation3DEffect(.degrees(Double(rotations.yRot * 180)), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint(x: 0.105, y: 0.105))
                    .rotation3DEffect(.degrees(Double(rotations.zRot * 90)), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: 0.105, y: 0.105))
                    .position(x: CGFloat(piece.position.x) + offset.width, y: CGFloat(piece.position.y) + offset.height)

                    //.scaleEffect(isDragging ? 1.2 : 1.0)
                    
                    .animation(.default, value: isDragging)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                //piece.position.x = Int(value.translation.width)
                                //piece.position.y = Int(value.translation.height)
                                //position = CGSize(width: value.translation.width, height: value.translation.height)
                                if !isDragging {
                                    startPos = CGPoint(x: CGFloat(piece.position.x), y: CGFloat(piece.position.y))
                                    isDragging = true
                                    scaleX *= 1.2
                                    scaleY *= 1.2
                                }
                                offset = value.translation
                                
                            }
                            .onEnded { value in
                                let xPos = Int(round((startPos.x + offset.width)/gameManager.unitSize)) * Int(gameManager.unitSize)
                                let yPos = Int(round((startPos.y + offset.height)/gameManager.unitSize)) * Int(gameManager.unitSize)
                                
                                // Update the piece's position to snap to the grid
                                piece.position.x = xPos
                                piece.position.y = yPos
                                offset = .zero
                                isDragging = false
                                scaleX /= 1.2
                                scaleY /= 1.2
                            }
                    )
                    .onTapGesture {
                        withAnimation {
                            rotations.zRot += 1
                        }
                    }
                    
                    .onLongPressGesture {
                        withAnimation {
                            rotations.yRot += 1
                        }
                    }
    }
}

struct PiecePreview: PreviewProvider {
    static var previews: some View {
        let gameManager = GameManager()
        @State var previewPiece = gameManager.pieces[3]
        PieceView(piece: $previewPiece)
            .environmentObject(gameManager)

    }
}

