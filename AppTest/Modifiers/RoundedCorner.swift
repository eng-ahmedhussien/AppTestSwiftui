//
//  RoundedCorner.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 16/02/2026.
//
import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct SpecificCornerRadius: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
            .frame(width: 300, height: 200)
            .padding()
//            .background(
//                backgroundGradient
//            )
            .cornerRadius(20, corners: [.topLeft, .bottomRight])
            .shadow(
                color: Color(.lightGray).opacity(0.8), // Color and opacity
                radius: 0,                             // Blur radius
                x: 0, y: 2                             // Offset
            )
    }
    
    private var backgroundGradient:some View{
        LinearGradient(
            colors: [.red, .green],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    SpecificCornerRadius()
}
