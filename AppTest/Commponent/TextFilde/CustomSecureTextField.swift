//
//  PasswordTextField.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 22/03/2025.
//

import SwiftUI


struct  SecureTextField: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack {
            Group {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ?  "eye": "eye.slash")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8) 
            }
        }
       
        .padding(.vertical)
        .padding(.horizontal, 24)
        .background(
            Color(UIColor.systemGray6)
        )
        .clipShape(Capsule(style: .continuous))
    }
}

// Preview for Xcode
#Preview {
    SecureTextField(password: .constant(""))
       //.frame(width: 100)
}




