//
//  CashPinConstants.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 04/02/2026.
//



import SwiftUI
import VFEAssets
// MARK: - Cash PIN Constants
struct CashPinConstants {
    
    // MARK: - Colors
    struct Colors {
        // Button Colors
        static let enabledBackground = Color(red: 0/255.0, green: 124/255.0, blue: 147/255.0) // Teal/Blue
        static let disabledBackground = Color(red: 199/255.0, green: 199/255.0, blue: 199/255.0) // Light Gray
        static let disabledText = Color(red: 103/255.0, green: 103/255.0, blue: 103/255.0) // Dark Gray
        
        // Text Colors
        static let primaryText = Color.black
        static let secondaryText = Color(red: 103/255.0, green: 103/255.0, blue: 103/255.0) // Dark Gray
        static let descriptionText = Color(red: 102/255.0, green: 102/255.0, blue: 102/255.0)
        static let enabledButtonText = Color.white
        static let VFENeutral2 = UIColor.fromHex(hexString: "#F2F2F2")

    }
    
    // MARK: - Fonts
    struct Fonts {
        static let headerTitle = Font(UIFont.VFEFont(ofSize: 18, weight: .regular))
        static let bodyText = Font(UIFont.VFEFont(ofSize: 14, weight: .regular))
        static let bodyTextBold = Font(UIFont.VFEFont(ofSize: 14, weight: .bold))
        static let buttonText = Font(UIFont.VFEFont(ofSize: 15, weight: .regular))
        static let cashTextFieldFont = Font(UIFont.VFEFont(ofSize: 16, weight: .regular))
    }
    
    // MARK: - Spacing & Dimensions
    struct Layout {
        // Padding
        static let horizontalPadding: CGFloat = 20
        static let topPadding: CGFloat = 20
        static let buttonVerticalPadding: CGFloat = 16
        
        // Spacing
        static let sectionSpacing: CGFloat = 24
        static let textFieldSpacing: CGFloat = 30
        static let headerSpacing: CGFloat = 16
        static let subtitleSpacing: CGFloat = 1
        
        // Corner Radius
        static let buttonCornerRadius: CGFloat = 8
    }
    
    // MARK: - Text Field Configuration
    struct TextFieldConfig {
        static let nationalIdMaxLength = 14
        static let pinCodeLength = 6
    }
    
    // MARK: - Alert Messages
    struct AlertMessages {
        // Success Messages
        static let createPinSuccessTitle = "Success"
        static let createPinSuccessMessage = "You have successfully created a PIN code for your account"
        static let resetPinSuccessTitle = "Thank You"
        static let resetPinSuccessMessage = "Congratulations! your pin code has been changed."
        
        // Error Messages
        static let errorTitle = "Error"
        // Button Text
        static let okButtonText = "OK"

        static let connectionErrorTitle = "Connection Error"
        static let wrongActivationKeyTitle = "Wrong Activation Key"
        static let notHaveVodafoneCashMessage = "Not Have Vodafone Cash"
        static let suspendedWalletTitle = "Suspended Wallet"
        static let suspendedWalletMessage = "10010"

    }
    
    // MARK: - Button Text
    struct ButtonText {
        static let createPin = "Create PIN"
        static let submit = "SubmitResetPin"
    }
    
    // MARK: - Placeholder Text
    struct Placeholders {
        static let nationalId = "Enter National ID number"
        static let enterPinCode = "Enter the 6 digit PIN code"
        static let reEnterPinCode = "Re-enter the 6 digit PIN code"
        static let newPinCode = "Please Enter the 6 Digits PIN Code"
        static let confirmNewPinCode = "Re-enter the 6 Digits PIN Code"
        static let verificationCodeCreatePin = "Enter the code you received in the SMS"
        static let verificationCodeResetPin = "Enter Verification Code"
    }
    
    // MARK: - Screen Titles and Descriptions
    struct ScreenContent {
        struct CreatePin {
            static let title = "Create pin code"
            static let subtitle1 = "You’ve successfully registered your Vodafone Cash wallet."
            static let subtitle2 = "You have to create a 6 digit PIN code (Non similar or consecutive) to start using your Vodafone cash wallet services and to ensure the safety and security of the money in your wallet."
        }
        
        struct ResetPin {
            static let title = "cashTitle8"
            static let description = "You need to create a 6 digit PIN code (Non Similar or consecutive) to ensure the safety and security of the money in your wallet."
        }
    }
}
