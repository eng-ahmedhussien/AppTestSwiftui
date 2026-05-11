import SwiftUI
// MARK: - Preset Configurations
extension VFCashTextFieldConfig {
    public static func pinCode(placeholder: String = "Enter PIN code") -> VFCashTextFieldConfig {
        var config = VFCashTextFieldConfig(placeholder: placeholder)
        config.keyboardType = .numberPad
        config.maxLength = 6
        config.isSecure = true
        config.allowedCharacterSet = .decimalDigits
        config.textFont = CashPinConstants.Fonts.cashTextFieldFont
        config.placeholderFont = CashPinConstants.Fonts.cashTextFieldFont
        config.secureErrorTextFont = Font(UIFont.VFEFont(ofSize: 12, weight: .regular))
        return config
    }
    
    public static func verificationCode(placeholder: String = "Enter verification code") -> VFCashTextFieldConfig {
        var config = VFCashTextFieldConfig(placeholder: placeholder)
        config.keyboardType = .numberPad
        config.maxLength = 8
        config.isSecure = true
        config.allowedCharacterSet = .decimalDigits
        config.textFont = CashPinConstants.Fonts.cashTextFieldFont
        config.placeholderFont = CashPinConstants.Fonts.cashTextFieldFont
        return config
    }
    
    public static func amount(placeholder: String = "Enter amount") -> VFCashTextFieldConfig {
        var config = VFCashTextFieldConfig(placeholder: placeholder)
        config.keyboardType = .decimalPad
        config.maxLength = 15
        config.isSecure = false
        config.allowedCharacterSet = CharacterSet(charactersIn: "0123456789.")
        config.textFont = CashPinConstants.Fonts.cashTextFieldFont
        config.placeholderFont = CashPinConstants.Fonts.cashTextFieldFont
        return config
    }
    
}

// MARK: - Input Validation Helpers (No changes here)
struct CashTextFieldValidator {
    // MARK: - PIN Code Validation
    static func validatePinCode(_ pinCode: String) -> String? {
        if pinCode.count != 6 || pinCode.isEmpty{
            return "invalid pin code, should be 6 digits".localize()
        }
        if isConsecutive(pinCode) {
            return "PIN code cannot contain consecutive digits (123456)".localize()
        }
        if isAllSame(pinCode) {
            return "PIN code cannot contain all same digits (111111)".localize()
        }
        return nil
    }

    // MARK: - PIN Code Match Validation
    static func validatePinCodeMatch(_ pin1: String, _ pin2: String) -> String? {
        if pin1 != pin2 {
            return "confirm pin code don't match pin code".localize()
        }
        if pin2.isEmpty {
            return ""
        }
        return nil
    }

    // MARK: - Verification Code Validation
    static func validateVerificationCode(_ code: String) -> String? {
        if code.isEmpty {
            return "invalid verification code, should not be empty".localize()
        }
        return nil
    }

    // MARK: - Amount Formatting
    static func formatAmount(_ amount: String) -> String {
        let filtered = amount.filter { "0123456789.".contains($0) }
        return filtered
    }

    // MARK: - National ID Validation
    static func validateNationalId(_ nationalId: String) -> String? {
        if nationalId.count != 14 {
            return "invalid national ID, should be 14 digits".localize()
        }
        return nil
    }

    // MARK: - Helper functions for PIN 
    private static func isConsecutive(_ pin: String) -> Bool {
        guard pin.count >= 2 else { return false }
        let digits = pin.compactMap { Int(String($0)) }
        for i in 0..<digits.count - 1 {
            if digits[i+1] != digits[i] + 1 && digits[i+1] != digits[i] - 1 {
                return false
            }
        }
        return true
    }

    private static func isAllSame(_ pin: String) -> Bool {
        guard let firstChar = pin.first else { return false }
        return pin.allSatisfy { $0 == firstChar }
    }
    
    static func isNumeric(_ inputString: String) -> Bool {
        return inputString.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
