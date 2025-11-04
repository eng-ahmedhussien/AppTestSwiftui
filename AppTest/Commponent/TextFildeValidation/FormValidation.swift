//
//  FormValidation.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 20/04/2025.
//

import SwiftUI
import Combine

struct FormValidation: View {
    var body: some View {
        SignUpView()
    }
}

#Preview {
    FormValidation()
}

struct SignUpView: View {
    
  @ObservedObject private var viewModel: SignUpViewModel
  
  init(viewModel: SignUpViewModel = SignUpViewModel()) {
      self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      Form {
          Section(footer: Text(viewModel.inlineErrorForName).foregroundColor(.red)) {
          TextField("Name", text: $viewModel.userName)
          TextField("Email", text: $viewModel.userEmail)
                        .keyboardType(.emailAddress)
          SecureField("Password", text: $viewModel.userPassword)
          SecureField("Repete the Password", text: $viewModel.userRepeatedPassword)
        }
        
        Button("Sign Up") {
          print("Button tapped")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .foregroundColor(.white)
        .opacity(buttonOpacity)
        .disabled(!viewModel.formIsValid)
      }
    }
  }
  
  var buttonOpacity: Double {
    return viewModel.formIsValid ? 1 : 0.5
  }
}


final class SignUpViewModel: ObservableObject {
    
    // Input values from View
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userPassword = ""
    @Published var userRepeatedPassword = ""
    
    // Output subscribers
    @Published var formIsValid = false
    @Published var inlineErrorForName = ""
    
    private var publishers = Set<AnyCancellable>()
    
    init() {
        isSignupFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
        
        isUserNameValid
            .dropFirst()
            .receive(on: RunLoop.main)
            .assign(to: \.inlineErrorForName, on: self)
            .store(in: &publishers)
        
        
    }
}

// MARK: - Setup validations

private extension SignUpViewModel {
    
    var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        $userName
            .map { name in
                return name.count >= 5
            }
            .eraseToAnyPublisher()
    }
    
    var isUserNameValid: AnyPublisher<String, Never> {
        $userName
            .map { name in
                if  name.count >= 5 {
                    return ""
                }else{
                    return "password should be at least 5 characters"
                }
            }
            .eraseToAnyPublisher()
    }
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $userEmail
            .map { email in
                let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $userPassword
            .map { password in
                return password.count >= 8
            }
            .eraseToAnyPublisher()
    }
    
    var passwordMatchesPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($userPassword, $userRepeatedPassword)
            .map { password, repeated in
                return password == repeated
            }
            .eraseToAnyPublisher()
    }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            isUserNameValidPublisher,
            isUserEmailValidPublisher,
            isPasswordValidPublisher,
            passwordMatchesPublisher)
        .map { isNameValid, isEmailValid, isPasswordValid, passwordMatches in
            return isNameValid && isEmailValid && isPasswordValid && passwordMatches
        }
        .eraseToAnyPublisher()
    }
}
