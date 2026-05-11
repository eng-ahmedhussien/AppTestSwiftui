//
//  AutoScrollModifier.swift
//  Vodafone business
//
//  Created by Mohamed Fawzy on 3/3/25.
//  Copyright © 2025 Vodafone Egypt. All rights reserved.
//

import SwiftUI


/// Modifier to auto-scroll a LazyHGrid
struct AutoScrollModifier: ViewModifier {
    let interval: TimeInterval
    let itemCount: Int
    let numOfRows: Int
    let anchor: UnitPoint
    
    @State private var currentIndex: Int = 0
    @State private var timer: Timer?
    
    init(interval: TimeInterval,
                itemCount: Int,
                numOfRows: Int,
                anchor: UnitPoint) {
        self.interval = interval
        self.itemCount = itemCount
        self.numOfRows = numOfRows
        self.anchor = anchor
    }
    
    func body(content: Content) -> some View {
        ScrollViewReader { proxy in
            content
                .onAppear {
                    startAutoScroll()
                }
                .onDisappear {
                    stopAutoScroll()
                }
                .onChange(of: currentIndex) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: anchor)
                    }
                }
        }
    }

}

// MARK: - Auto Scrolling Control
extension AutoScrollModifier {
    
    private func startAutoScroll() {
        stopAutoScroll()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                goToNextIndex()
        }
    }
    
    private func goToNextIndex() {
        DispatchQueue.main.async {
            currentIndex = (currentIndex + numOfRows) % itemCount
        }
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}

extension View {
    /// Applies an automatic scrolling effect to a view using a timer.
    /// - Parameters:
    ///   - tags: An array of unique identifiers corresponding to the scrollable items.
    ///   - interval: The time interval (in seconds) between automatic scrolls.
    ///   - numOfRows: The number of rows to skip per scroll.
    ///   - anchor: The alignment point where the scrolling should focus (default is `.leading`).
    /// - Returns: A modified view that automatically scrolls at the specified interval.
#warning("will be delete AnyView()")
    public func autoScroll(
                    interval: TimeInterval,
                    itemCount: Int,
                    numOfRows: Int,
                    anchor: UnitPoint = .leading) -> some View {
          guard interval > 0 else { return AnyView(self) }
        return AnyView(self.modifier(AutoScrollModifier(
                                                interval: interval,
                                                itemCount: itemCount,
                                                numOfRows: numOfRows,
                                                anchor: anchor)))
      }
}

#Preview {
    VStack(spacing: 20) {
        Text("Auto Scroll Demo")
            .font(.title)
            .padding()
        
        Text("Horizontal scrolling every 2 seconds")
            .font(.caption)
            .foregroundColor(.secondary)
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(0..<10, id: \.self) { index in
                    VStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 150, height: 180)
                            .overlay(
                                Text("Item \(index)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            )
                        
                        Text("Description \(index)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .id(index)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 200)
        .autoScroll(
            interval: 2.0,
            itemCount: 10,
            numOfRows: 2,
            anchor: .leading
        )
        
        Text("Vertical scrolling every 1.5 seconds")
            .font(.caption)
            .foregroundColor(.secondary)
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(0..<8, id: \.self) { index in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.green.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Text("\(index)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Vertical Item \(index)")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("This is a vertical scrolling item with auto-scroll")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .id(index)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 100) // Height equal to one element
        .autoScroll(
            interval: 1.5,
            itemCount: 8,
            numOfRows: 1,
            anchor: .top
        )
        
        Spacer()
    }
    .padding()
}
