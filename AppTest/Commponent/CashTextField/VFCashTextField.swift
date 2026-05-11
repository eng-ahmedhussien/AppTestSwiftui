//
// VFCashTextField.swift
// CashSwiftUi
//
// Created by Menna on 22/07/2025.
//

import SwiftUI

// MARK: - Main Reusable Text Field Component
public struct VFCashTextField: View {
    // MARK: - Properties
    private let config: VFCashTextFieldConfig
    @Binding private var text: String
    private let errorMessage: String?
    private let accessibilityId: String
    @State private var isFocused: Bool = false
    
    // MARK: - Computed Properties
    private var currentBorderColor: Color {
        if let message = errorMessage, !message.isEmpty {
            return config.errorBorderColor
        } else if isFocused {
            return config.focusedBorderColor
        } else {
            return config.borderColor
        }
    }
    
    private var currentInputTextColor: Color {
        if let message = errorMessage, !message.isEmpty {
            return config.errorTextColor
        } else {
            return config.textColor
        }
    }
    
    private var currentInputFieldFont: Font {
        if config.isSecure, let message = errorMessage, !message.isEmpty {
            return config.secureErrorTextFont
        } else {
            return config.textFont
        }
    }
    
    @ViewBuilder
    private var placeholderView: some View {
        if text.isEmpty {
            Text(config.placeholder)
                .foregroundColor(config.placeholderColor)
                .font(config.placeholderFont)
                .allowsHitTesting(false)
                .accessibilityIdentifier(CashTextFieldId.placeholderLabel.rawValue)
        }
    }

    @ViewBuilder
    private var inputField: some View {
        Group {
            if config.isSecure {
                SecureField("", text: $text)
                    .font(currentInputFieldFont)
                    .foregroundColor(currentInputTextColor)
            } else {
                TextField("", text: $text, onEditingChanged: { editing in
                    self.isFocused = editing
                })
                .font(config.textFont)
                .foregroundColor(currentInputTextColor)
            }
        }
    }

    @ViewBuilder
    private var errorView: some View {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            HStack(spacing: 1) {
                config.errorIcon?
                    .resizable()
                    .frame(width: config.errorIconSize, height: config.errorIconSize)
                    .foregroundColor(config.errorTextColor)

                Text(errorMessage)
                    .font(config.errorFont)
                    .foregroundColor(config.errorTextColor)
            }
            .accessibilityIdentifier(CashTextFieldId.errorMessage.rawValue)
        }
    }

    // MARK: - Initializer
    public init(
        config: VFCashTextFieldConfig,
        text: Binding<String>,
        errorMessage: String? = nil,
        accessibilityId: String? = nil
    ) {
        self.config = config
        self._text = text
        self.errorMessage = errorMessage
        self.accessibilityId = accessibilityId ?? (config.isSecure ? CashTextFieldId.securedField.rawValue : CashTextFieldId.inputField.rawValue)
    }
    
    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .leading) {

                placeholderView

                inputField
                    .keyboardType(config.keyboardType)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .accessibilityIdentifier(accessibilityId)
                    .disabled(config.isDisabled)
            }
            .padding(.vertical, config.verticalPadding)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(currentBorderColor),
                alignment: .bottom
            )

            errorView
        }
        .onChange(of: text) { newValue in
            if newValue.count > config.maxLength {
                text = String(newValue.prefix(config.maxLength))
            }
            if let allowedCharacterSet = config.allowedCharacterSet {
                let filtered = newValue.filter { character in
                    allowedCharacterSet.contains(character.unicodeScalars.first!)
                }
                if filtered != newValue {
                    text = filtered
                }
            }
        }
    }
}

// MARK: - Preview 
struct CashTextField_Previews: PreviewProvider {
    @State static var pinCodeText = ""
    @State static var reEnterPinCodeText = "123"
    @State static var verificationCodeText = ""
    @State static var amountText = ""
    @State static var genericText = ""
    @State static var pinCodeError: String? = nil
    @State static var reEnterPinCodeError: String? = "PIN codes don't match."
    @State static var verificationCodeError: String? = nil
    @State static var genericError: String? = nil
    
    static var previews: some View {
        VStack(spacing: 30) {
            Text("CashTextField Examples")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            // PIN Code field (Normal State)
            VFCashTextField(
                config: .pinCode(placeholder: "Enter the 6-digit PIN code"),
                text: $pinCodeText,
                errorMessage: pinCodeError
            )
            .onChange(of: pinCodeText) { newValue in
                pinCodeError = CashTextFieldValidator.validatePinCode(newValue)
            }
            
            // Re-enter PIN Code field (Error State with smaller, red dots)
            VFCashTextField(
                config: .pinCode(placeholder: "Re-enter the 6-digit PIN code"),
                text: $reEnterPinCodeText,
                errorMessage: reEnterPinCodeError // This will trigger the red/smaller dots
            )
            .onChange(of: reEnterPinCodeText) { newValue in
                let pinFormatError = CashTextFieldValidator.validatePinCode(newValue)
                if pinFormatError != nil {
                    reEnterPinCodeError = pinFormatError
                } else {
                    reEnterPinCodeError = CashTextFieldValidator.validatePinCodeMatch(pinCodeText, newValue)
                }
            }
            
            // Verification code field (Empty, will show placeholder)
            VFCashTextField(
                config: .verificationCode(placeholder: "Enter the code from SMS"),
                text: $verificationCodeText,
                errorMessage: verificationCodeError
            )
            .onChange(of: verificationCodeText) { newValue in
                verificationCodeError = CashTextFieldValidator.validateVerificationCode(newValue)
            }
            
            // Amount field (focused, will change border color)
            VFCashTextField(
                config: .amount(placeholder: "Enter amount to transfer"),
                text: $amountText,
                errorMessage: nil
            )
            .onChange(of: amountText) { newValue in
                amountText = CashTextFieldValidator.formatAmount(newValue)
            }
            
            // Generic Text Field (disabled state)
            VFCashTextField(
                config: VFCashTextFieldConfig(
                    placeholder: "This field is disabled",
                    isDisabled: true
                ),
                text: .constant("Some disabled text"),
                errorMessage: nil
            )
            
            // Generic Text Field with a long placeholder and error
            VFCashTextField(
                config: .generic(placeholder: "Enter your full name as per ID", keyboardType: .namePhonePad),
                text: $genericText,
                errorMessage: genericError
            )
            .onChange(of: genericText) { newValue in
                if newValue.isEmpty {
                    genericError = "Name cannot be empty."
                } else if newValue.count < 3 {
                    genericError = "Name is too short."
                } else {
                    genericError = nil
                }
            }
        }
        .padding()
        .dismissKeyboardOnTap()
        
    }
}
