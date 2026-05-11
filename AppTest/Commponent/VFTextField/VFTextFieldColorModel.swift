//
//  VFTextFieldColorModel.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 23/02/2026.
//


import SwiftUI

public struct VFTextFieldColorModel  {
    /// Text color.
    public var textColor: Color
    /// Floating label color.
    public var floatingLabelColor: Color
    /// Normal label color.
    public var normalLabelColor: Color
    /// Outline line color.
    public var outlineColor: Color

    /// Creates a new color model.
    /// - Parameters:
    ///   - textColor: Text color
    ///   - floatingLabelColor: Floating label color
    ///   - normalLabelColor: Normal label color
    ///   - outlineColor: Outline line color
    public init(textColor: Color, floatingLabelColor: Color, normalLabelColor: Color, outlineColor: Color) {
        self.textColor = textColor
        self.floatingLabelColor = floatingLabelColor
        self.normalLabelColor = normalLabelColor
        self.outlineColor = outlineColor
    }
}

public enum VFTextFieldState {
    case normal
    case editing
    case disabled
    case error
    /// Textfield color model to get color for each label.
    public var colorModel: VFTextFieldColorModel {
        switch self {
        case .normal:
            return VFTextFieldColorModel(textColor: VFTextfieldConstants.blackColor,
                                          floatingLabelColor: VFTextfieldConstants.blackColor,
                                          normalLabelColor: VFTextfieldConstants.lightGrayColor,
                                          outlineColor: VFTextfieldConstants.lightGrayColor)
        case .editing:
            return VFTextFieldColorModel(textColor: VFTextfieldConstants.blackColor,
                                          floatingLabelColor: VFTextfieldConstants.blackColor,
                                          normalLabelColor: VFTextfieldConstants.blackColor,
                                          outlineColor: VFTextfieldConstants.turqoiseColor)
        case .disabled:
            return VFTextFieldColorModel(textColor: VFTextfieldConstants.blackColor,
                                         floatingLabelColor: VFTextfieldConstants.blackColor,
                                         normalLabelColor: VFTextfieldConstants.lightGrayColor,
                                         outlineColor: VFTextfieldConstants.lightGrayColor)
        case .error:
            return VFTextFieldColorModel(textColor: VFTextfieldConstants.blackColor,
                                          floatingLabelColor: VFTextfieldConstants.blackColor,
                                          normalLabelColor: VFTextfieldConstants.blackColor,
                                          outlineColor: VFTextfieldConstants.redColor)
        }
    }
    /// Outline line width.
    public var outlineWidth: CGFloat {
        switch self {
        case .normal:
            return 1
        case .editing:
            return 2
        case .disabled:
            return 1
        case .error:
            return 1
        }
    }
}
