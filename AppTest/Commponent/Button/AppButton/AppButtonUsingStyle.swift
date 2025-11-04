//
//  CustomButtonKind.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 23/09/2025.
//


import SwiftUI


struct AppButtonUsingStyle: ButtonStyle {
    let kind: ButtonKind
    let width: CGFloat?
    let height: CGFloat?
    let disabled: Bool
    let backgroundColor: Color
    
    // Default initializer with default values
       init(kind: ButtonKind = .solid, width: CGFloat? = nil, height: CGFloat? = nil, disabled: Bool = false,backgroundColor: Color = .red) {
           self.kind = kind
           self.width = width
           self.height = height
           self.disabled = disabled
           self.backgroundColor = backgroundColor
       }

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        return configuration.label
            .padding()
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .foregroundColor(foregroundColor)
            .background(background(isPressed: isPressed, color: backgroundColor))
            .padding(.horizontal,5)
            .opacity(disabled ? 0.6 : 1.0)
    }

    private var foregroundColor: Color {
        switch kind {
        case .solid:
            return .white
        case .border:
            return disabled ? .gray.opacity(0.8) : .red
        case .plain:
            return disabled ? .gray.opacity(0.8) : .black
        }
    }

    @ViewBuilder
    private func background(isPressed: Bool,color: Color) -> some View {
        switch kind {
        case .solid:
            RoundedRectangle(cornerRadius: 30)
                .fill(disabled ? Color.gray : (isPressed ? color.opacity(0.7) : color))
        case .border:
            RoundedRectangle(cornerRadius: 30)
                .stroke(disabled ? .gray.opacity(0.8) : .red, lineWidth: 1)
        case .plain:
            Color.clear
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        Section {
            VStack {
                Button("Solid") {}
                    .buttonStyle(AppButtonUsingStyle(kind: .solid))
                Button("Border") {}
                    .buttonStyle(AppButtonUsingStyle(kind: .border))
                Button("Plain") {}
                    .buttonStyle(AppButtonUsingStyle(kind: .plain))
            }
        } header: {
            Text("Enabled styles")
                .alignHorizontally(.leading)
        }

        Section {
            VStack {
                Button("Solid (Disabled)") {}
                    .buttonStyle(AppButtonUsingStyle(kind: .solid, disabled: true))
                Button("Border (Disabled)") {}
                    .buttonStyle(AppButtonUsingStyle(kind: .border, disabled: true))
                Button("Plain (Disabled)") {}
                    .buttonStyle(AppButtonUsingStyle(kind: .plain, disabled: true))
            }
        } header: {
            Text("Disabled styles")
                .alignHorizontally(.leading)
        }
        
        Section {
            VStack {
                Button("default style") {}
                    .buttonStyle(AppButtonUsingStyle())
                
                HStack{
                    Button("custom style") {}
                        .buttonStyle(
                            AppButtonUsingStyle(
                                kind: .solid,
                                height: 50,
                                disabled: false,
                                backgroundColor: .blue
                            )
                        )
                    Button("custom style") {}
                        .buttonStyle(
                            AppButtonUsingStyle(
                                kind: .border,
                                height: 50,
                                disabled: false,
                                backgroundColor: .blue
                            )
                        )
                    
                    Button("custom style") {}
                        .buttonStyle(
                            AppButtonUsingStyle(
                                kind: .plain,
                                disabled: false
                            )
                        )
                    
                    
                }
            }
        } header: {
            Text("default and custom styles")
                .alignHorizontally(.leading)
        }

    }
    .padding()
    .background(Color(.systemBackground))
}
