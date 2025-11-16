//
//  AppTextField.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 08/04/2025.
//

import SwiftUI


#Preview {
    AppTextField_Previews()
}


struct AppTextField_Previews: View {
    @State private var name = ""
    @State private var password = ""
    @State private var isValid = true
    @State private var error = ""
    @State private var error2 = ""

    var body: some View {
        VStack{
            AppTextField(
                text: $name,
                placeholderText: "name",
                validation: .isEmpty,
                isValid: $isValid,
                errorText: $error
            )
          
            
            AppTextField(
                text: $password,
                placeholderText: "password",
                isSecure: true,
                validation: .password,
                isValid: $isValid,
                errorText: $error2
            )
        }
       
    }
    
}

enum ValidationType {
    case isEmpty
    case mobileNumber
    case email
    case password
    case confirmPassword(password: Binding<String>)
    case limit(min: Double?, max: Double?)
    case equal(number: Int)
    case numeric
    case numbericFloat
    case nationalID
    case mobile_Email
    case textWithReg(regex: String) // New case for regex validation

}

struct AppTextField: View {

    @Binding var text: String
    let placeholderText: String
    var isSecure: Bool
    let validation: ValidationType?
    @Binding var isValid: Bool
    @Binding var errorText: String
    @State private var showPassword: Bool = false

    init(
        text: Binding<String>,
        placeholderText: String,
        isSecure: Bool = false,
        validation: ValidationType? = nil,
        isValid: Binding<Bool> = .constant(true), // Add Binding for isValid
        errorText: Binding<String> = .constant("")
    ) {
        self._text = text
        self.placeholderText = placeholderText
        self.isSecure = isSecure
        self.validation = validation
        self._isValid = isValid  // Bind the isValid property
        self._errorText = errorText
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                textField
                    .onChange(of: text){ newValue in
                        validate(text: newValue)
                    }
                
                if isSecure {
                    showPasswordButton
                }
            }
            .padding()
            .border(.black)
            .padding()
          
            /// Bottom Label
            bottomLabel(text: errorText)
            
        }
    }
    
    
    //MARK: Show Password
    private var showPasswordButton: some View {
        Button(action: togglePassword) {
            Image(systemName:
                    showPassword ? "eye" : "eye.slash")
            .foregroundColor(.gray)
        }
    }
    
    private func togglePassword() {
        showPassword.toggle()
    }
    
    //MARK: TextField
    @ViewBuilder private var textField: some View {
        if isSecure && !showPassword {
            SecureField(placeholderText, text: $text)
        } else {
            TextField(placeholderText, text: $text)
                //.submitLabel(submitLabel)
        }
    }
    
    @ViewBuilder private func bottomLabel(text: String) -> some View {
        if !text.isEmpty {
            Text(text)
                .font(.subheadline)
                .foregroundColor(.red)
                .padding(.horizontal, 16)
        } else {
            EmptyView()
        }
    }
    
}

extension AppTextField {
    func validate(text: String) {
        func validEmail()->Bool{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: text) ? false : true
        }
        
        // Mobile
        func validMobile()->Bool{
            let formatter: NumberFormatter = NumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
            let number = formatter.number(from: text)
            if number == nil || text.count < 10 {
                return false
            }else{
                return true
            }
        }
        
       if text != "" {
//            guard let validation = validation else {
//                data.isValid = true
//                return
//            }
           
           switch validation {
           case .isEmpty:
               let newText = text.trimmingCharacters(in: .whitespacesAndNewlines)
               if newText.isEmpty {
                   self.errorText = "Please fill the field"
                   self.isValid = false
                   return
               }
           case .mobileNumber:
               
               
               if validMobile() == false {
                   self.errorText = "Please enter a valid phone number"
                   self.isValid = false
                   return
               }
               
           case .email:
               
               
               if validEmail() {
                   self.errorText = "Please enter a valid email"
                   self.isValid = false
                   return
               }
               
           case .password:
               if !(text.count >= 6 && text.count <= 255) {
                  self.errorText =  "Password should be at least 6 characters long"
                   self.isValid = false
                   return
               }
               
           case .confirmPassword(let password):
               if password.wrappedValue != text {
                   self.errorText = "The password doesn't match"
                   self.isValid = false
                   return
               }
               
           case .limit(min: let min, max: let max):
               if  Double(text) ?? 0.0 < min ?? 0.0 || Double(text) ?? 0.0 > max ?? 0.0 {
                   self.errorText = String(format: "Limit_Validation".localized(), min ?? 0.0 , max ?? 0.0)
                   self.isValid = false
                   return
               }
               // TODO: Add implementation
               break
               
           case .equal(number: let number):
               if text.count != number {
                   self.errorText = "The number of characters should equal to" + "\(number)"
                   self.isValid = false
                   return
               }else{
                   self.errorText = ""
                   self.isValid = true
               }
               
           case .numeric:
               if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: text)) {
                   self.errorText = "Please enter a number"
                   self.isValid = false
                   return
               }
               
           case .numbericFloat:
               let formatter = NumberFormatter()
               formatter.allowsFloats = true
               if formatter.number(from: text) == nil {
                  self.errorText = "Please enter a number"
                   self.isValid = false
                   return
               }
               
           case .nationalID:
               if text.count != 10 {
                   self.errorText = "Please enter a valid national ID"
                   self.isValid = false
                   return
               }
           case .mobile_Email:
               if text.first == "0"{
                   if validMobile() == false {
                       self.errorText = "Please enter a valid phone number"
                       self.isValid = false
                       return
                   }
               }else{
                   if validEmail() {
                       self.errorText = "Please enter a valid email"
                       self.isValid = false
                       return
                   }
               }
           case .textWithReg(let regex):
               debugPrint(regex , text)
               let regexPred = NSPredicate(format: "SELF MATCHES %@", regex)
               if !regexPred.evaluate(with: text) {
                  self.errorText = "Please enter a valid phone number"
                   self.isValid = false
                   return
               }
           case .none:
               self.isValid = true
           }
       }else{
           self.isValid = false
           self.errorText = ""
           return
       }
       self.isValid = true
      // data.state = .normal
   }
}
