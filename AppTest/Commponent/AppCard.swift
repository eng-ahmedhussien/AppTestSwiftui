//
//  AppCard.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 04/02/2026.
//

import SwiftUI

/// Card view with background
public struct AppCard<Content: View>: View {
    var padding: CGFloat
    var backgroundColor: Color
    let content: Content
    
    /// Initializes a new VFCard with customizable padding and background color.
    ///
    /// This initializer creates a card view that wraps content with padding and a background
    /// color. The card provides a consistent visual container for content with rounded corners
    /// and customizable styling.
    ///
    /// - Parameters:
    ///   - padding: The padding to apply around the content. Defaults to 10 points.
    ///   - backgroundColor: The background color of the card. Defaults to `Color.VFESurface`.
    ///   - content: A closure that returns the content to be displayed inside the card.
    ///     This closure is marked with `@ViewBuilder` to allow for complex view hierarchies.
    ///
    public init(padding: CGFloat = 10,
         backgroundColor: Color = Color(.systemBackground),
         @ViewBuilder content: () -> Content) {
        self.content = content()
        self.padding = padding
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        content
            .padding(.all,padding)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(backgroundColor)
                   // .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 2)
            )
    }
}

//struct AppCard2: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .padding(10)
//            .background(
//                RoundedRectangle(cornerRadius: 12, style: .continuous)
//                    .fill(Color(.systemBackground))
//                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 2)
//            )
//    }
//}

extension View {
    func appCard(
        padding: CGFloat = 10,
        background: Color = Color(.systemBackground),
        shadowColor: Color = Color.black.opacity(0.15),
        shadowRadius: CGFloat = 6,
        x: CGFloat = 0,
        y: CGFloat = 2
    ) -> some View {
        self
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(background)
                    .shadow(color: shadowColor, radius: shadowRadius, x: x, y: y)
            )
    }
}

#Preview {
    VStack{
        AppCard{
            VStack{
                    Text("SwiftUI Card")
                        .font(.title)
                        .foregroundColor(.blue)
                    Divider()
                    Text("Reusable component with background")
                        .font(.subheadline)
                        .foregroundColor(.gray)
            }
        }
        .padding()
        
        VStack{
            Text("SwiftUI Card")
                .font(.title)
                .foregroundColor(.blue)
            Divider()
            Text("Reusable component with background")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .appCard()
        .padding()
      
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemGroupedBackground))
}
