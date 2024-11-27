//
//  CustomShapes.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/16/24.
//

import SwiftUI

struct CustomShapes: Shape {
    var letterAmount: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if letterAmount == 5 {
            // Top
            path.move(to: CGPoint(x: rect.midX, y: rect.midY * 0.5))
            // Right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            // Bottom
            path.addLine(to:CGPoint(x: rect.midX,y: rect.midY * 1.5))
            // Left
            path.addLine(to:CGPoint(x: rect.minX,y: rect.midY))
            path.closeSubpath()
        }
        else if letterAmount == 6 {
            // Top
            path.move(to: CGPoint(x: rect.midX, y: rect.midY * 0.5))
            // Right top
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY*0.8))
            // Right bottom
            path.addLine(to: CGPoint(x: rect.midX * 1.6, y: rect.midY * 1.4))
            // Left bottom
            path.addLine(to: CGPoint(x: rect.midX * 0.4, y: rect.midY * 1.4))
            // Left Top
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.8))
            path.closeSubpath()
        }
        else {
            // Top left
            path.move(to: CGPoint(x: rect.midX * 0.5, y: rect.midY * 0.5))
            // Top right
            path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.midY * 0.5))
            // Right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 0.9))
            // Bottom right
            path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.midY * 1.35))
            // Bottom left
            path.addLine(to: CGPoint(x: rect.midX * 0.5, y: rect.midY * 1.35))
            // Left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.9))
            path.closeSubpath()
        }
        
        return path
    }
}

#Preview {
    CustomShapes(letterAmount: 5)
        .stroke(Color.blue, lineWidth: 4)
}

