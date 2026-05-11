//
//  VFGrid.swift
//  SwiftUIDemo
//
//  Created by Mohamed Fawzy on 2/22/25.
//

import SwiftUI

/// A view that arranges its children in a grid layout.
public struct VFGrid<Content: View>: View {
    let config: VFGridConfig
    let itemsCount: Int
    let content: (Int) -> Content
    
    private var const: Constants
    @State private var availableSize: CGSize = .zero
    @State private var itemWidth: CGFloat = 0
    @State private var itemHeight: CGFloat = 0
    
    /// Creates a new instance that generates views based on the given parameters.
    /// - Parameters:
    ///  - config: The configuration of the grid.
    ///  - numberofItems: The number of items in the grid.
    ///  - content: A view builder that creates the content of each
    public init(config: VFGridConfig,
         itemsCount: Int,
         constants: Constants = Constants(),
         @ViewBuilder content: @escaping (Int) -> Content){
        self.config = config
        self.content = content
        self.itemsCount = itemsCount
        self.const = constants
    }
    
    public var body: some View {
        grid
            .saveSize(in: $availableSize)
            .onChange(of: availableSize.width) { newValue in
                calculateItemSize(availableWidth: newValue)
            }
    }
    
    @ViewBuilder
    private var grid: some View {
        switch config.scrollType {
        case .infinitePager:
            Text("circularPagingItems")
        case .horizontal:
            horizontalItems
        case .vertical:
            verticalItems
        case .paging:
            pagingItems
        }
    }
}

// MARK: - Grid Layouts
extension VFGrid {
    
    // MARK: - Horizontal
    private var horizontalItems: some View {
        let gridItem = GridItem(.fixed(itemHeight), spacing: const.interColumnSpacing)
        let rows = Array(repeating: gridItem , count: config.numberOfRows)
        return ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows,
                      spacing: const.interRowSpacing) {items}
        }
        .autoScroll(interval: config.autoScrollDuration,
                    itemCount: itemsCount,
                    numOfRows: config.numberOfRows)
    }
    
    // MARK: - Vertical
    private var verticalItems: some View {
        let gridItem = GridItem(.flexible(), spacing: const.interRowSpacing)
        let columns = Array(repeating: gridItem , count: config.numberOfColumn)
        
        return ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: const.interColumnSpacing) {items}
        }
    }
    
    // MARK: - Paging
    #warning("will be delete AnyView()")
    private var pagingItems: some View {
        if config.numberOfRows > 1 || config.numberOfColumn > 1 {
            return AnyView(pagingGridItem)
        }
        return AnyView(pagingSingleItem)
    }
//    private var circularPagingItems: some View {
//        VFCircularPager(
//                config: config,
//                itemsCount: itemsCount,
//                content: content
//        )
//    }
    
    /// grid with multiple rows and columns paging
    private var pagingGridItem: some View {
        let chunks = Array(0..<itemsCount).chunked(into: config.numberOfRows * config.numberOfColumn)
        let gridItem = GridItem(.fixed(itemHeight), spacing: const.interColumnSpacing)
        let rows = Array(repeating: gridItem, count: config.numberOfRows)
        
        return VFPagingView(pageCount: chunks.count,
                            autoScrollInterval: config.autoScrollDuration) { index in
            let currentChunk = chunks[index]
            LazyHGrid(rows: rows ,alignment: .center, spacing: const.interRowSpacing) {
                ForEach(currentChunk, id: \.self) {item(at: $0)}
            }
        }
    }
 
    /// full width paging item
    private var pagingSingleItem: some View {
        return VFPagingView(pageCount: itemsCount,
                            autoScrollInterval: config.autoScrollDuration) {item(at: $0)}
    }
    
    // MARK: - Items
    private var items: some View {
        ForEach(0..<itemsCount, id: \.self){ index in
            item(at: index)
        }
    }
    
    private func item(at index: Int) -> some View {
        content(index)
            .frame(width: itemWidth, height: itemHeight)
    }
}

// MARK: - item Size Calculation
extension VFGrid {
    private func calculateItemSize(availableWidth: CGFloat) {
        calculateItemWidth(availableWidth: availableWidth)
        calculateItemHeight(fromCellWidth: itemWidth)
    }
    
    private func calculateItemWidth(availableWidth: CGFloat){
        let numOfColumns = CGFloat(config.numberOfColumn)
        let totalSpaceBetweenColumns = (const.interColumnSpacing) * (numOfColumns - 1)
        // in case of horizontal scroll leave space for extra cell indicator
        var gridWidth: CGFloat = availableWidth
        if config.scrollType == .horizontal && itemsCount > 1 { gridWidth -= gridWidth * const.extraCellIndicatorWidthRatio}
        let itemWidth = (gridWidth - totalSpaceBetweenColumns)/numOfColumns
        self.itemWidth = itemWidth
    }
    
    private func calculateItemHeight(fromCellWidth width: CGFloat) {
        let heightWidthRatio = CGFloat(config.heightToWidthRatio)
        self.itemHeight = width * heightWidthRatio
    }
}

// MARK: - Constants
extension VFGrid {
    public struct Constants {
        public var interColumnSpacing: CGFloat
        public var interRowSpacing: CGFloat
        public var extraCellIndicatorWidthRatio: CGFloat
        public var anchor: UnitPoint = .leading
        public init(interColumnSpacing: CGFloat = 10, interRowSpacing: CGFloat = 10, extraCellIndicatorWidthRatio: CGFloat = 0.08, anchor: UnitPoint = .leading) {
            self.interColumnSpacing = interColumnSpacing
            self.interRowSpacing = interRowSpacing
            self.extraCellIndicatorWidthRatio = extraCellIndicatorWidthRatio
            self.anchor = anchor
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        Text("VFGrid Demo")
            .font(.title)
        
        // Example 1: Horizontal scrolling grid
        VStack(alignment: .leading, spacing: 8) {
            Text("Horizontal Grid (2 rows, 3 columns)")
                .font(.headline)
            
            VFGrid(
                config: VFGridConfig(
                    scrollType: .horizontal,
                    numberOfColumn: 3,
                    numberOfRows: 2,
                    heightToWidthRatio: 1.0,
                    autoScrollDuration: 3.0
                ),
                itemsCount: 12
            ) { index in
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.3))
                        .overlay(
                            Text("\(index + 1)")
                                .font(.headline)
                                .foregroundColor(.primary)
                        )
                }
            }
        }
        
        // Example 2: Vertical scrolling grid
        VStack(alignment: .leading, spacing: 8) {
            Text("Vertical Grid (3 columns)")
                .font(.headline)
            
            VFGrid(
                config: VFGridConfig(
                    scrollType: .vertical,
                    numberOfColumn: 3,
                    numberOfRows: 5,
                    heightToWidthRatio: 1
                ),
                itemsCount: 15
            ) { index in
                VStack {
                    Circle()
                        .fill(Color.green.opacity(0.3))
                        .overlay(
                            Text("\(index + 1)")
                                .font(.headline)
                                .foregroundColor(.primary)
                        )
                }
            }
        }
        
        // Example 3: Single item paging
        VStack(alignment: .leading, spacing: 8) {
            Text("Single Item Paging")
                .font(.headline)
            
            VFGrid(
                config: VFGridConfig(
                    scrollType: .paging,
                    numberOfColumn: 1,
                    numberOfRows: 1,
                    heightToWidthRatio: 0.4,
                    autoScrollDuration: 1.5
                ),
                itemsCount: 5
            ) { index in
                VStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.purple.opacity(0.3))
                        .overlay(
                            VStack(spacing: 8) {
                                Image(systemName: "star.fill")
                                    .font(.title)
                                    .foregroundColor(.yellow)
                                Text("Featured \(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Special content")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        )
                }
            }
        }
                
        // Example 4: circular paging view  with animation
        VStack(alignment: .leading, spacing: 8) {
            Text("Circular pagger with animation")
                .font(.headline)
            
            VFGrid(
                config: VFGridConfig(
                    scrollType: .infinitePager,
                    numberOfColumn: 1,
                    numberOfRows: 1,
                    heightToWidthRatio: 0.4,
                    autoScrollDuration: 2.5
                ),
                itemsCount: 3,
                constants: .init(anchor: .center)
                
            ) { index in
                VStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.purple.opacity(0.3))
                        .overlay(
                            VStack(spacing: 8) {
                                Image(systemName: "star.fill")
                                    .font(.title)
                                    .foregroundColor(.yellow)
                                Text("Featured \(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Special content")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        )
                }
            }//.background(Color.red)
        }

    }
    .padding()
}
