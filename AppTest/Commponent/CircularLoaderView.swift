//
//  TopCurvedShape.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 15/04/2025.
//

import SwiftUI

struct CircularLoaderView: View {
    @State private var isLoading = false
    var strokeColor: Color = .accentColor
    var strokeWidth: CGFloat = 4.0
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(Animation.default.repeatForever(autoreverses: false), value: isLoading)
            .onAppear() {
                self.isLoading = true
            }
    }
}

struct CircularLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        CircularLoaderView()
            .frame(width: 50, height: 50)
    }
}

