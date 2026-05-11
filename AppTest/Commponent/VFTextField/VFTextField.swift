//
//  VFTextField.swift
//  Vodafone business
//
//  Created by Soha Ahmed Hamdy on 01/02/2025.
//  Copyright © 2025 khaled saad. All rights reserved.
//

import SwiftUI
import VFESwiftUIModels

public struct VFTextFeild: View {
    @FocusState private var isFocused
    @Binding var text: String
    @Binding var state: VFTextFieldState
    var floatingText: String
    var normalText: String
    var errorText: String? = nil
    let iconSize: CGFloat

    /// Optional Icons
    var iconIdentifier: String? = nil
    var textFieldIdentifier: String? = nil
    var trailingIcon: Image? = nil
    var trailingIconAction: (() -> ())? = nil
    
    var onChange: ((String) -> Void)? = nil
    private let constants: VFTextfieldConstants = VFTextfieldConstants()
    
    /// Creates a new text field with floating label, state management, and optional trailing icons.
    ///
    /// - Parameters:
    ///   - text: Binding to the text value that will be displayed and edited in the text field.
    ///   - state: Binding to the text field state that controls appearance and behavior (normal, editing, error, disabled).
    ///   - floatingText: The floating label text that appears above the text field when focused or when text is present.
    ///   - normalText: The placeholder text shown when the text field is empty and not focused.
    ///   - errorText: Optional error message to display below the text field when state is error.
    ///   - iconIdentifier: Optional accessibility identifier for the trailing icon for testing purposes.
    ///   - textFieldIdentifier: Optional accessibility identifier for the text field for testing purposes.
    ///   - iconSize: Optional custom size for the trailing icon. Defaults to the standard icon size from constants.
    ///   - trailingIcon: Optional trailing icon image to display on the right side of the text field.
    ///   - trailingIconAction: Optional action closure that will be called when the trailing icon is tapped.
    ///   - onChange: Optional closure called whenever the text value changes.
    ///
    /// - Note: The text field automatically handles state transitions:
    ///   - Changes to `.editing` when focused
    ///   - Changes to `.normal` when unfocused
    ///   - Changes from `.error` to `.editing` when user starts typing
    ///   - Prevents state changes when `.disabled`
    public init(text: Binding<String>,
         state: Binding<VFTextFieldState>,
         floatingText: String,
         normalText: String,
         errorText: String? = nil,
         iconIdentifier: String? = nil,
         textFieldIdentifier: String? = nil,
         iconSize: CGFloat? = nil,
         trailingIcon: Image? = nil,
         trailingIconAction: (() -> Void)? = nil,
         onChange: ((String) -> Void)? = nil)
    {
        self._text = text
        self._state = state
        self.floatingText = floatingText
        self.normalText = normalText
        self.errorText = errorText
        self.iconIdentifier = iconIdentifier
        self.textFieldIdentifier = textFieldIdentifier
        self.iconSize = iconSize ?? constants.iconSize
        self.trailingIcon = trailingIcon
        self.trailingIconAction = trailingIconAction
        self.onChange = onChange
    }
    
    public var body: some View{
        VStack{
            ZStack(alignment: .leading) {
                floatingLabel
                normalLabel
                textFeild
            }
            .frame(minHeight: constants.initialHeight)
            .background(
                RoundedRectangle(cornerRadius: constants.cornerRadius)
                    .fill(Color.VFESurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: constants.cornerRadius)
                            .stroke(state.colorModel.outlineColor, lineWidth: state.outlineWidth)
                    )
            )
            .opacity(state == .disabled ? 0.65 : 1)
            .onTapGesture(perform: {
                if state != .disabled {
                    isFocused = true
                }
            })
            
            if state == .error {
                /// Error label
                errorView
            }
        }
    }
    
    /// Determines the floating label offset and scale effect
    private var floatingLabelStyle: (offset: CGFloat, scale: CGFloat) {
        let isFloating = state == .editing || !text.isEmpty
        return (offset: isFloating ? constants.floatingLabelOffset : 0, scale: isFloating ? 0.8 : 1.0)
    }
    
    private var normalLabelOffset: CGFloat {
        let isFloating = state == .editing || !text.isEmpty
        return isFloating ? 10 : 0
    }
    
    private var errorView: some View {
        Group{
            if let errorText = errorText {
                HStack{
                    Text(errorText)
                        .foregroundColor(constants.errorLabelColor)
                        .font(constants.errorLableFont)
                    Spacer()
                }
                .padding(.horizontal, constants.errorLabelPadding)
                .automationIdLeaf(VFTextFeildAutomationId.ErrorIcon.rawValue)
            }
        }
    }
    
    private var floatingLabel: some View {
        Text(floatingText)
            .foregroundColor(state.colorModel.floatingLabelColor)
            .font(constants.floatingLableFont)
            .offset(y: floatingLabelStyle.offset) /// Move placeholder up when focused
            .scaleEffect(floatingLabelStyle.scale, anchor: .leading) /// Shrink placeholder
            .padding(.horizontal, constants.defaultPadding)
            .animation(.linear(duration: constants.animationDuration), value: state)
            .automationIdLeaf(VFTextFeildAutomationId.FloatingLabel.rawValue)
    }
    
    private var normalLabel: some View {
        Group{
            if (state == .editing) && text.isEmpty {
                Text(normalText)
                    .foregroundColor(state.colorModel.normalLabelColor)
                    .font(constants.normalLableFont)
                    .offset(y: normalLabelOffset)
                    .padding(.horizontal, constants.defaultPadding)
                    .animation(.linear(duration: constants.animationDuration), value: state)
            }
        }
        .automationIdLeaf(VFTextFeildAutomationId.normalLabel.rawValue)
    }
    
    private var textFeild: some View {
        HStack{
            TextField("", text: $text, onEditingChanged: { editing in
                if state != .disabled {
                    if editing {
                        state = .editing
                    } else if state != .error {
                        state = .normal
                    }
                }
                
            })
            .focused($isFocused)
            .accessibilityIdentifier(textFieldIdentifier ?? "")
            .disabled(state == .disabled)
            .onChange(of: text) { newValue in
                if state == .error {
                    state = .editing
                }
                onChange?(newValue)
            }
            .padding(constants.defaultPadding)
            .font(constants.textLableFont)
            .offset(y: normalLabelOffset)
            .foregroundColor(state.colorModel.textColor)
            Spacer()
            
            /// Optional icons
            if state == .error {
                iconView(icon: constants.errorIcon)
            }
            
            iconView(icon: trailingIcon, action: trailingIconAction)
                .accessibilityIdentifier(iconIdentifier ?? "")
        }
    }
    

    
    @ViewBuilder
    private func iconView(icon: Image?, action: (()->())? = nil) -> some View {
        if let icon = icon {
            Button(action: {
                action?()
            }, label: {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(constants.iconForegroundColor)
                    .padding(.trailing, constants.iconTraling)
            })
            .automationIdLeaf(VFTextFeildAutomationId.TrailingIcon.rawValue)
        }
    }
}

#Preview {
    struct VFETextFeildPreview: View {
        @State var text: String = ""
        @State var state: VFTextFieldState = .normal
        
        var body: some View {
            VStack{
                /// How to use
                VFTextFeild(text: $text, state: $state, floatingText: "Employee Num: 010xxxxx", normalText: "Enter your text", errorText: "error in number you entered")
                
                Spacer()
                
                VFButton(title: "error") {
                    state = .error
                }
                
                VFButton(title: "disable") {
                    state = .disabled
                }
                
                VFButton(title: "normal") {
                    state = .normal
                }
                
            }
            .padding()
        }
    }
    
    return VFETextFeildPreview()
}
