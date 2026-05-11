//
//  AppShimmerModifier.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 08/02/2026.
//


import SwiftUI

struct AppShimmerModifier: ViewModifier {
    private let constants = ShimmerEffectConstants()
    var customShimmerColors: [Color]? = nil
    
    @State private var startPoint: UnitPoint = UnitPoint(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = UnitPoint(x: 0, y: -0.2)
    @Binding var on: Bool
    
    init(on: Binding<Bool>, customShimmerColors: [Color]? = nil) {
        self._on = on
        self.customShimmerColors = customShimmerColors
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                VStack{
                    if on {
                        RoundedRectangle(cornerRadius: constants.cornerRadius)
                            .fill(
                                LinearGradient(
                                    colors: customShimmerColors ?? constants.gradientColors,
                                    startPoint: startPoint,
                                    endPoint: endPoint)
                            )
                            .onAppear{
                                withAnimation(
                                    .linear(duration: constants.animationDuration)
                                    .repeatForever(autoreverses: false)
                                ) {
                                    startPoint = constants.finalStartPoint
                                    endPoint = constants.finalEndPoint
                                }
                            }
                    }
                }
            )
    }
}

private struct ShimmerEffectConstants {
    let cornerRadius: CGFloat = 4
    let animationDuration: Double = 1.5
    
    let gradientColors = [
        Color(.systemGray5),
        Color(.systemGray4),
        Color.white.opacity(0.7),
        Color(.systemGray4),
        Color(.systemGray5)
    ]
    
    let initialStartPoint = UnitPoint(x: -1.8, y: -1.2)
    let initialEndPoint = UnitPoint(x: 0, y: -0.2)
    
    let finalStartPoint = UnitPoint(x: 1, y: 1)
    let finalEndPoint = UnitPoint(x: 2.2, y: 2.2)
    
    let shimmerID = "VFShimmerEffect"
}

extension View {
    /// Adds a shimmering loading effect to any view with configurable animation.
    ///
    /// This modifier creates a smooth shimmer animation that moves across the view,
    /// commonly used to indicate loading states for content placeholders.
    ///
    ///
    /// - Parameter on: Binding to control whether the shimmer effect is active
    /// - Returns: A view with the shimmer effect applied when `on` is true
    ///
    /// ## Usage
    /// ```swift
    /// Rectangle()
    ///     .fill(Color.gray)
    ///     .frame(height: 100)
    ///     .Shimmering(on: $isLoading)
    /// ```
    ///
    /// ## Features
    /// - Smooth linear gradient animation
    /// - Configurable duration (1.5 seconds by default)
    /// - Automatic repeat forever animation
    /// - Rounded corners for polished appearance
    public func AppShimmering(on: Binding<Bool>, customShimmerColors: [Color]? = nil) -> some View {
        self.modifier(AppShimmerModifier(on: on, customShimmerColors: customShimmerColors))
    }
}

#Preview {
    @State var isLoading: Bool = true
    VStack{

        // Image from URL
        VFImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRWBC6C3Zj0P61_H8gT5lhbJDmQTNpSLW4Ow&s")!,
                placeholder: "empty-credit-cards",
                width: 200,
                height: 200)

    }
    .AppShimmering(on: $isLoading)
    //.redacted(reason: .placeholder)
    
}
