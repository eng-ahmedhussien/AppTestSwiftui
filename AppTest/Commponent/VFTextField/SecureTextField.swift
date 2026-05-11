//
//  SecureTextField.swift
//  VFESwiftUI
//
//  Created by Soha Ahmed Hamdy on 07/07/2025.
//

import SwiftUI
import UIKit

struct SecureTextField: UIViewRepresentable {
    @Binding var text: String
    var isSecure: Bool
    var onEditingChanged: ((Bool) -> Void)? = nil

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.isSecureTextEntry = isSecure
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textDidChange(_:)), for: .editingChanged)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        uiView.isSecureTextEntry = isSecure
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onEditingChanged: onEditingChanged)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onEditingChanged: ((Bool) -> Void)?

        init(text: Binding<String>, onEditingChanged: ((Bool) -> Void)?) {
            _text = text
            self.onEditingChanged = onEditingChanged
        }

        @objc func textDidChange(_ textField: UITextField) {
            self.text = textField.text ?? ""
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            onEditingChanged?(true)
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            onEditingChanged?(false)
        }
    }
}

