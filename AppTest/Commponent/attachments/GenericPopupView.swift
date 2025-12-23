//
//  GenericPopupView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//


import SwiftUI
import MijickPopupView

struct GenericPopupView: CentrePopup {
    let title: String?
    let message: String?
    let onAction: (@MainActor () -> Void)?
    let buttonTitle: String?
        
        func createContent() -> some View {
            VStack {
                if let title = title {
                    Text(title.localized())
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(.all, 12)
                }
                
                if let message = message {
                    Text(message.localized())
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.all, 12)
                }
                
                if let  buttonTitle = buttonTitle {
                    AppButton(state: .constant(.normal),
                              style: .stroke(primaryColor: .black),
                              action: {
                        dismiss()
                        Task {
                            guard let onAction = onAction else {return}
                            onAction()
                        }
                    },builder: {
                        Text(buttonTitle.localized())
                            .font(.headline)
                            .foregroundColor(.black)
                    }).padding(.all, 12)
                }
            }
            .padding()
            .overlay(alignment: .topTrailing, content: {
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.gray)
                }
                .padding()
                
            })
        }
        
        func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
            popup.tapOutsideToDismiss(true)
        }
    }
#Preview {
    GenericPopupView(title: "test", message: "test message ", onAction: {}, buttonTitle: "test")
}
