//
//  FullCustomTextFilde.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 08/04/2025.
//

import SwiftUI

struct AppTextFieldPreview: View {
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var age = ""
    @State private var phoneNumber = ""
    
    var body: some View {
        VStack(spacing: 20) {
            CustomTextField(text: $password, placeholder: "Enter password", validationRules: [.isEmpty, .password],
                isSecure: true
            )
            
            CustomTextField(text: $confirmPassword, placeholder: "Confirm password",validationRules: [.isEmpty, .confirmPassword($password)],
                isSecure: true
            )
            
            CustomTextField(text: $age, placeholder: "Enter your age", validationRules: [.numeric, .limit(min: 13, max: 120)]
            )
            
            CustomTextField(text: $phoneNumber,placeholder: "Enter mobile number",  validationRules: [.isEmpty, .phone]
            )
        }
        .padding()
    }
}
#Preview {
    AppTextFieldPreview()
}


struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var validationRules: [ValidationRule]
    var isSecure: Bool = false
    
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showPassword = false
    @FocusState private var isFocused: Bool
    @State private var hasInteracted = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Group {
                    if isSecure && !showPassword {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
               // .focused($isFocused)
                .onChange(of: text, perform: { _ in
                    if text.isEmpty {
                        resetValidation()
                    } else {
                        validateInput()
                    }
                })

                if isSecure {
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(showError ? .red : .gray, lineWidth: 1)
            )
            
            if showError {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showError)
    }
    
    private func resetValidation() {
        showError = false
        errorMessage = ""
    }
    
    private func validateInput() {
        showError = false
        errorMessage = ""
        
        for rule in validationRules {
            if let error = rule.validate(text) {
                showError = true
                errorMessage = error
                break
            }
        }
    }
}
enum ValidationRule {
    case isEmpty
    case phone
    case password
    case confirmPassword(Binding<String>)
    case limit(min: Double?, max: Double?)
    case numeric
}

extension ValidationRule {
    func validate(_ value: String) -> String? {
        switch self {
        case .isEmpty:
            return value.isEmpty ? "This field cannot be empty" : nil
            
        case .phone:
            let phoneRegex = "^(?:\\+?20|0)?1[0125][0-9]{8}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return predicate.evaluate(with: value) ? nil : "Phone number must start with +20 (e.g. +201XXXXXXXXX)"
            
        case .password:
            let pattern = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$"#
              let regexMatch = value.range(of: pattern, options: .regularExpression) != nil
              return regexMatch ? nil : "Password must be 8+ characters, with uppercase, lowercase, number, and symbol."
            
        case .confirmPassword(let binding):
            return value == binding.wrappedValue ? nil : "Passwords do not match"
            
        case .limit(let min, let max):
            guard let numericValue = Double(value) else {
                return "Must be a valid number"
            }
            var errors = [String]()
            if let min = min, numericValue < min {
                errors.append("Value must be ≥ \(min)")
            }
            if let max = max, numericValue > max {
                errors.append("Value must be ≤ \(max)")
            }
            return errors.isEmpty ? nil : errors.joined(separator: " and ")
            
        case .numeric:
            return Double(value) == nil ? "Must be a numeric value" : nil
        }
    }
    
    
    
}
