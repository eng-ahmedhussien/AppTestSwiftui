//
//  VFPagger.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 04/02/2026.
//


import SwiftUI

public struct VFPagger: View {
    // MARK: - Properties
    var pages: Int
    var selectedPage: Int
    
    /// The maximum number of dots that will show in the control
    var maxDots: Int = 7
    /// The number of dots that will be centered and full-sized
    var centerDots: Int = 3
    /// The size of the dots
    var dotSize: CGFloat = 6
    /// The space between dots
    var spacing: CGFloat = 4
    /// The color of all the unselected dots
    var dotColor: Color = .gray
    ///The color of the currently selected dot
    var selectedColor: Color = .blue
    /// The duration, in seconds, of the dot slide animation
    var slideDuration: Double = 0.15
    
    // MARK: - Private Variables
    @State private var pageOffset: Int = 0
    @State private var centerOffset: Int = 0
    
    /// Initializes a new VFPagger with the specified configuration for page indicators.
    ///
    /// This initializer creates a pagination control that displays dots representing pages,
    /// with smooth animations and customizable appearance. The component automatically
    /// handles dot scaling, visibility, and centering based on the selected page.
    ///
    /// - Parameters:
    ///   - pages: The total number of pages to display dots for
    ///   - selectedPage: The currently selected page index (0-based)
    ///   - maxDots: The maximum number of dots that will be visible at once. Defaults to 7
    ///   - centerDots: The number of dots that will be centered and full-sized. Defaults to 3
    ///   - dotSize: The base size of each dot in points. Defaults to 6
    ///   - spacing: The space between dots in points. Defaults to 4
    ///   - dotColor: The color of unselected dots. Defaults to VFENeutral4
    ///   - selectedColor: The color of the currently selected dot. Defaults to VFEPrimary
    ///   - slideDuration: The duration of dot slide animations in seconds. Defaults to 0.15
    public init(pages: Int,
                selectedPage: Int,
                maxDots: Int = 7,
                centerDots: Int = 3,
                dotSize: CGFloat = 6,
                spacing: CGFloat = 4,
                dotColor: Color = .gray,
                selectedColor: Color = .blue,
                slideDuration: Double = 0.15) {
        self.pages = pages
        self.selectedPage = selectedPage
        self.maxDots = maxDots
        self.centerDots = centerDots
        self.dotSize = dotSize
        self.spacing = spacing
        self.dotColor = dotColor
        self.selectedColor = selectedColor
        self.slideDuration = slideDuration
        
    }
    
    public var body: some View {
        let centerDotsCount = min(centerDots, pages)
        let centerPage = centerDotsCount / 2 + pageOffset
        
        HStack(spacing: spacing) {
            ForEach(0..<pages, id: \.self) { index in
                Circle()
                    .fill(index == selectedPage ? selectedColor : dotColor)
                    .frame(width: scaledSize(for: index, centerPage: centerPage),
                           height: scaledSize(for: index, centerPage: centerPage))
                    .opacity(isVisible(index,centerPage: centerPage) ? 1 : 0)
                    .animation(.easeInOut(duration: slideDuration), value: selectedPage)
            }
        }
        .frame(maxWidth: .infinity)
        .onChange(of: selectedPage) { newPage in
            updateOffsets(for: newPage)
        }
    }
    
    // MARK: - Private Methods
    private func scaledSize(for index: Int, centerPage: Int) -> CGFloat {
        dotSize * scaleFactor(for: index, centerPage: centerPage)
    }
    
    private func scaleFactor(for index: Int, centerPage: Int) -> CGFloat {
        let distance = abs(index - centerPage)
        if distance > maxDots / 2 { return 0 }
        return [1, 0.66, 0.33, 0.16][max(0, min(3, distance - centerDots / 2))]
    }
    
    private func isVisible(_ index: Int, centerPage: Int) -> Bool {
        abs(index - centerPage) <= maxDots / 2
    }
    
    private func updateOffsets(for newPage: Int) {
        let maxOffset = pages - centerDots
        if newPage - pageOffset >= 0 && newPage - pageOffset < centerDots {
            /// Keep the dots within the visible range
            centerOffset = newPage - pageOffset
        } else {
            /// Shift the offset to keep the selected page centered
            pageOffset = max(0, min(newPage - centerOffset, maxOffset))
        }
    }
}

#Preview {
    struct VFPaggerPreview: View {
        private var pages = 6
        @State private var selectedPage = 0

        var body: some View {
            VStack{
                HStack{
                    Spacer()
                    /// How to use
                    VFPagger(pages: pages, selectedPage: selectedPage)
                        .frame(width: 100, height: 20)
                        .padding()
                }

                Button("Next Page") {
                    selectedPage = (selectedPage + 1) % pages
                }
            }
            .padding()
        }
    }
    
    return VFPaggerPreview()
}
