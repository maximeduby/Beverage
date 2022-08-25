//
//  Wave.swift
//  Beverage
//
//  Created by Maxime Duby on 27/07/2022.
//

import SwiftUI

struct Wave: Shape {
    var amplitude: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY), control1: CGPoint(x: rect.maxX * 0.25, y: -rect.maxY * amplitude), control2: CGPoint(x: rect.maxX * 0.75, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()
        
        
        return path
    }
}

struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        Wave(amplitude: 0.3)
            .stroke(Color.red, lineWidth: 5)
            .frame(height: 400)
            .padding()
    }
}
