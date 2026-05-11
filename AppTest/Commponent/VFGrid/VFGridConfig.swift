import Foundation

public struct VFGridConfig: Equatable, Hashable {
    public var scrollType: VFGridScrollType
    public var numberOfColumn: Int
    public var numberOfRows: Int
    public var heightToWidthRatio: Float
    public var autoScrollDuration: Double = 0
    
    /// Initializes a new VFGridConfig with the specified grid layout and behavior parameters.
    ///
    /// This initializer creates a configuration object that defines how a grid should be laid out
    /// and behave. It controls the grid's dimensions, scrolling behavior, and auto-scroll functionality.
    ///
    /// - Parameters:
    ///   - scrollType: The type of scrolling behavior for the grid. This determines whether the grid
    ///     scrolls horizontally, vertically, or not at all. Use this to control the grid's scroll direction.
    ///   - numberOfColumn: The number of columns in the grid. This defines how many items will be
    ///     displayed in each row. Must be a positive integer.
    ///   - numberOfRows: The number of rows in the grid. This defines how many rows of items will be
    ///     displayed. Must be a positive integer.
    ///   - heightToWidthRatio: The ratio of height to width for each grid item. This controls the
    ///     aspect ratio of individual items in the grid. A value of 1.0 creates square items.
    ///   - autoScrollDuration: The duration in seconds for automatic scrolling. Defaults to 0 (no auto-scroll).
    ///     When greater than 0, the grid will automatically scroll at the specified interval.
    ///
    public init(scrollType: VFGridScrollType,
                numberOfColumn: Int,
                numberOfRows: Int,
                heightToWidthRatio: Float,
                autoScrollDuration: Double = 0) {
        self.scrollType = scrollType
        self.numberOfColumn = numberOfColumn
        self.numberOfRows = numberOfRows
        self.heightToWidthRatio = heightToWidthRatio
        self.autoScrollDuration = autoScrollDuration
    }
        
}
