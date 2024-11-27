//
//  Ring Shape.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import SwiftUI

struct RingShape: Shape {
    var percent: Double
    let startAngle: Double = -90
    
    var animatableData: Double {
        get {
            return percent
        }
        set {
            percent = newValue
        }
    }
    
    init(percent: Double) {
        self.percent = percent
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let radius = min(width, height) / 2
        let center = CGPoint(x: width / 2, y: height / 2)
        let endAngle = Angle(degrees: RingShape.percentToAngle(percent: self.percent, startAngle: self.startAngle))
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: endAngle, clockwise: false)
        }
    }
    
    static func percentToAngle(percent: Double, startAngle: Double) -> Double {
        (percent / 100 * 360) + startAngle
    }
}

#Preview {
    RingShape(percent: 70)
        .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .round))
        .fill(Color.green)
        .frame(width: 300, height: 300)
}
