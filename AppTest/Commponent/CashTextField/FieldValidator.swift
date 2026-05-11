//
//  FieldValidator.swift
//  Ana Vodafone
//
//  Created by Menna on 28/12/2025.
//  Copyright © 2025 Vodafone Egypt. All rights reserved.
//
// MARK: - Field Validation Protocol

import Foundation
enum ValidationError: LocalizedError {
    case invalidPinCode(String)
    case pinCodeMismatch(String)
    case invalidVerificationCode(String)
    case invalidNationalId(String)
    case invalidAmount(String)
    case generic(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidPinCode(let message),
             .pinCodeMismatch(let message),
             .invalidVerificationCode(let message),
             .invalidNationalId(let message),
             .invalidAmount(let message),
             .generic(let message):
            return message
        }
    }
}
