//
// VFCashTextFieldModels.swift
// CashSwiftUi
//
// Created by Menna on 22/07/2025.
//

import SwiftUI
import VFEAssets
// MARK: - CashTextField Configuration Model
public struct VFCashTextFieldConfig {
    public var placeholder: String
    public var keyboardType: UIKeyboardType
    public var maxLength: Int
    public var isSecure: Bool
    public var isDisabled: Bool
    public var borderColor: Color
    public var focusedBorderColor: Color
    public var errorBorderColor: Color
    public var textColor: Color
    public var textFont: Font
    public var placeholderFont: Font
    public var verticalPadding: CGFloat
    public var errorTextColor: Color
    public var errorIcon: Image?
    public var errorFont: Font
    public var errorIconSize: CGFloat
    public var secureErrorTextFont: Font
    public var allowedCharacterSet: CharacterSet?
    public var placeholderColor: Color
    public init(
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        maxLength: Int = 50,
        isSecure: Bool = false,
        isDisabled: Bool = false,
        borderColor: Color = .gray.opacity(0.5),
        focusedBorderColor: Color = .gray.opacity(0.5),
        errorBorderColor: Color = .red,
        textColor: Color = .black,
        textFont: Font = Font(UIFont.VFEFont(ofSize: 16, weight: .regular)),
        placeholderFont: Font = Font(UIFont.VFEFont(ofSize: 16, weight: .regular)),
        verticalPadding: CGFloat = 12,
        errorTextColor: Color = .red,
        errorIcon: Image? = nil,
        errorFont: Font = Font(UIFont.VFEFont(ofSize: 12, weight: .regular)),
        errorIconSize: CGFloat = 16,
        secureErrorTextFont: Font = Font(UIFont.VFEFont(ofSize: 12, weight: .regular)),
        allowedCharacterSet: CharacterSet? = nil,
        placeholderColor: Color = Color(red: 201/255.0, green: 201/255.0, blue: 201/255.0)
    ) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.maxLength = maxLength
        self.isSecure = isSecure
        self.isDisabled = isDisabled
        self.borderColor = borderColor
        self.focusedBorderColor = focusedBorderColor
        self.errorBorderColor = errorBorderColor
        self.textColor = textColor
        self.textFont = textFont
        self.placeholderFont = placeholderFont
        self.verticalPadding = verticalPadding
        self.errorTextColor = errorTextColor
        self.errorIcon = errorIcon
        self.errorFont = errorFont
        self.errorIconSize = errorIconSize
        self.secureErrorTextFont = secureErrorTextFont
        self.allowedCharacterSet = allowedCharacterSet
        self.placeholderColor = placeholderColor
    }
    public static func generic(placeholder: String, keyboardType: UIKeyboardType = .default, maxLength: Int = 50, isSecure: Bool = false) -> VFCashTextFieldConfig {
        let config = VFCashTextFieldConfig(
            placeholder: placeholder,
            keyboardType: keyboardType,
            maxLength: maxLength,
            isSecure: isSecure
        )
        return config
    }
}
// MARK: - Keyboard Utilities
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    public func dismissKeyboardOnTap() -> some View {
        self.onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - Automation Identifiers
public enum CashTextFieldId: String {
    case inputField = "cash_input_field"
    case securedField = "cash_secured_field"
    case errorMessage = "cash_error_message"
    case placeholderLabel = "cash_placeholder_label"
}
