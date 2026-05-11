import SwiftUI
import VFEAssets

public struct VFTextfieldConstants {
    // MARK: - Colors
    public static let turqoiseColor =  Color.VFESecondary
    public static let blackColor = Color.VFEOnSurface
    public static let lightGrayColor = Color.VFEOutline
    public static let redColor = Color.VFEError
    // MARK: - Error
    public var errorLabelColor = redColor
    public var errorIcon: Image? = Image("Alert")

    // MARK: - Fonts
    public var normalLableFont: Font = .VFEFont(ofSize: 18, weight: .regular)
    public var floatingLableFont: Font = .VFEFont(ofSize: 14, weight: .regular)
    public var textLableFont: Font = .VFEFont(ofSize: 18, weight: .regular)
    public var errorLableFont: Font = .VFEFont(ofSize: 14, weight: .regular)
    
    public var initialHeight: CGFloat = 58
    public var animationDuration: TimeInterval = 0.15
    public var errorLabelTopPadding: CGFloat = 2
    public var leadingPadding: CGFloat = 12
    public var floatingLabelOutlineSidePadding: CGFloat = 4
    public var floatingLabelOffset: CGFloat = -16
    public var noramlLabelOffset: CGFloat = 8
    public var cornerRadius: CGFloat = 12
    public var defaultPadding: CGFloat = 16
    public var errorLabelPadding: CGFloat = 10

     // MARK: - Icons
    public var iconSize: CGFloat = 24
    public var iconTraling: CGFloat = 10
    public var iconForegroundColor: Color = blackColor
    
    public init() {}
}

// MARK: - Identifiers
public enum VFTextFeildAutomationId: String {
    case InputFeild, SecuredFeild, ErrorIcon, TrailingIcon, FloatingLabel, normalLabel
}
