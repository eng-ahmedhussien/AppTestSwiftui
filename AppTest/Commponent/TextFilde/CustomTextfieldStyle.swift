//
//  LabelTextView.swift
//  AppTest
//
//  Created by ahmed hussien on 29/04/2024.
//

import SwiftUI

struct Preview: View {
    @State var password: String = ""
    @State var name: String = ""
    @State var errorMessage: String = ""
    
  
    var passwordPrompt: String {
        if password.isEmpty || isPasswordValid() {
            return ""
        } else {
            return "Must be 8–15 characters, include 1 number and 1 uppercase letter"
        }
    }
    
    func isPasswordValid() -> Bool {
        // criteria in regex.  See http://regexlib.com
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$")
        return passwordTest.evaluate(with: password)
    }
    
    var body: some View {
        VStack{
            TextField("password", text: $password)
                .withCustomTextFieldStyle(errorMessage: passwordPrompt)
            
            ZStack(alignment: .leading) {
                if password.isEmpty {
                    
                    Text("Course title")
                        .bold()
                        .foregroundColor(Color.purple.opacity(0.4))
                }
                TextField("", text: $password)
                    .withCustomTextFieldStyle(errorMessage: passwordPrompt)
            }
        }
    }
    
}

#Preview{
    Preview()
}


//MARK: -  1 extension view with custom TextFieldStyle
struct MainTextFieldStyle : TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(
                Color(UIColor.systemGray6)
            )
            .clipShape(Capsule(style: .continuous))
        
    }
}
struct LeadingTextFieldView <ContentLeading: View>:TextFieldStyle {
    let leadingView: ContentLeading
    
    init(@ViewBuilder leadingView: () -> ContentLeading = { EmptyView() }){
        self.leadingView = leadingView()
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            leadingView
            configuration
        }
        
    }
}
struct TrailingTextFieldView <ContentTrailing: View>: TextFieldStyle {
    let trailingView: ContentTrailing
    
    init(@ViewBuilder trailingView: () -> ContentTrailing = {
            EmptyView() }
    ){
        self.trailingView = trailingView()
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            configuration
            trailingView
        }
    }
}

/// we make this extension to make easy use like " .mainTextFieldStyle "
extension View {
    func mainTextFieldStyle() -> some View {
        textFieldStyle(MainTextFieldStyle())
    }
    
    func leadingView<Leading: View>(
        @ViewBuilder leadingView: @escaping () -> Leading = { EmptyView() }
    ) -> some View {
        self.textFieldStyle(LeadingTextFieldView(leadingView: leadingView))
    }
    
    func trailingView<Trailing: View>(
        @ViewBuilder trailingView: @escaping () -> Trailing = { EmptyView() }
    ) -> some View {
        self.textFieldStyle(TrailingTextFieldView(trailingView: trailingView))
    }
}

//MARK: -  2 extension TextField
extension TextField {
    func extensionTextFieldView() -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(
                Color(UIColor.systemGray6)
            )
            .clipShape(Capsule(style: .continuous))
    }
}

//MARK: -  3 ViewModifier
struct CustomTextFieldStyle : ViewModifier {
    var showError: Bool = true
    var errorMessage: String? = nil
    
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing:10) {
            content
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .padding(.horizontal, 24)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke( errorMessage == nil ? .red : .gray , lineWidth: 1)
                )
            
                Text(errorMessage ?? "")
                    .foregroundColor(.red)
                    .font(.caption)
        }
            
    }
} 
extension View {
    func withCustomTextFieldStyle(errorMessage: String) -> some View {
        self
            .modifier(CustomTextFieldStyle(errorMessage: errorMessage))
    }
}





