//
//  OTPFieldsConfig.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 12/05/2026.
//


import SwiftUI

// MARK: - Configuration

struct OTPFieldsConfig {
    // Layout
    var slotSpacing: CGFloat = 8
    var slotHeight: CGFloat = 50
    var verticalPadding: CGFloat = 12
    var horizontalPadding: CGFloat = 20
    var cornerRadius: CGFloat = 6

    // Border
    var defaultBorderWidth: CGFloat = 1
    var filledBorderWidth: CGFloat = 1
    var defaultBorderColor: Color = Color(.systemGray4)
    var filledBorderColor: Color = Color(.systemGray4)
    var errorBorderColor: Color = .red

    // Background
    var defaultBackgroundColor: Color = Color(.systemBackground)
    var filledBackgroundColor: Color = Color(.systemGray6)

    // Text
    var textColor: Color = .primary
    var font: Font = .system(size: 14, weight: .regular)

    // Behavior
    var keyboardType: UIKeyboardType = .numberPad
    var secureCharacter: String = "✱"
}

// MARK: - View

struct OTPFieldsView: View {

    private let config: OTPFieldsConfig
    private var isSecureEntry: Bool
    private var isError: Bool
    private let slotCount: Int

    @FocusState private var isFocused: Bool
    @Binding var code: String
    @Binding var isKeyboardVisible: Bool

    var onChange: ((String) -> Void)?
    var onComplete: ((String) -> Void)?

    init(
        slotCount: Int = 6,
        code: Binding<String>,
        isKeyboardVisible: Binding<Bool>,
        isSecureEntry: Bool = false,
        isError: Bool = false,
        config: OTPFieldsConfig = OTPFieldsConfig(),
        onChange: ((String) -> Void)? = nil,
        onComplete: ((String) -> Void)? = nil
    ) {
        self._code = code
        self._isKeyboardVisible = isKeyboardVisible
        self.slotCount = slotCount
        self.isSecureEntry = isSecureEntry
        self.isError = isError
        self.config = config
        self.onChange = onChange
        self.onComplete = onComplete
    }

    var body: some View {
        ZStack {
            HStack(spacing: config.slotSpacing) {
                ForEach(0..<slotCount, id: \.self) { index in
                    let character = characterAt(index)

                    Text(character)
                        .font(config.font)
                        .foregroundColor(config.textColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, config.verticalPadding)
                        .background(
                            RoundedRectangle(cornerRadius: config.cornerRadius)
                                .fill(character.isEmpty ? config.defaultBackgroundColor : config.filledBackgroundColor)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: config.cornerRadius)
                                .stroke(
                                    borderColor(for: character),
                                    lineWidth: borderWidth(for: character)
                                )
                        )
                }
            }

            TextField("", text: $code)
                .keyboardType(config.keyboardType)
                .textContentType(.oneTimeCode)
                .foregroundColor(.clear)
                .accentColor(.clear)
                .focused($isFocused)
                .onChange(of: code) { newValue in
                    if newValue.count > slotCount {
                        code = String(newValue.prefix(slotCount))
                    }
                    onChange?(code)
                    if code.count == slotCount {
                        onComplete?(code)
                    }
                }
                .onChange(of: isKeyboardVisible) { show in
                    isFocused = show
                }
        }
        .contentShape(Rectangle())
        .onTapGesture { isFocused = true }
        .onAppear { isFocused = isKeyboardVisible }
    }

    // MARK: - Helpers

    private func characterAt(_ index: Int) -> String {
        guard index < code.count else { return "" }
        let char = code[code.index(code.startIndex, offsetBy: index)]
        return isSecureEntry ? config.secureCharacter : String(char)
    }

    private func borderColor(for character: String) -> Color {
        if isError { return config.errorBorderColor }
        return character.isEmpty ? config.defaultBorderColor : config.filledBorderColor
    }

    private func borderWidth(for character: String) -> CGFloat {
        if isError { return config.filledBorderWidth }
        return character.isEmpty ? config.defaultBorderWidth : config.filledBorderWidth
    }
}

// MARK: - Preview

#Preview {
    struct PreviewWrapper: View {
        @State private var code = ""
        @State private var isKeyboardVisible = true

        var body: some View {
            OTPFieldsView(
                slotCount: 6,
                code: $code,
                isKeyboardVisible: $isKeyboardVisible,
                onChange: { print("Partial: \($0)") },
                onComplete: { print("Complete: \($0)") }
            )
            .frame(height: 50)
            .padding(.horizontal, 20)
        }
    }
    return PreviewWrapper()
}
