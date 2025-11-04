//
//  AppButton.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 08/05/2025.
//

import SwiftUI
struct AppButton_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var state: ButtonState = .normal

        var body: some View {
            VStack(spacing: 20) {
                AppButton(state: $state, style: .solid()) {
                    print("Solid Button Pressed")
                } builder: {
                    Text("Solid Button")
                }.frame(width: 200, height: 40)

                AppButton(state: $state, style: .stroke()) {
                    print("Stroke Button Pressed")
                } builder: {
                    Text("Stroke Button")
                }.frame(width: 200, height: 40)

                AppButton(state: $state, style: .plain) {
                    print("Plain Button Pressed")
                } builder: {
                    Text("Plain Button")
                }.frame(width: 200, height: 40)

                AppButton(state: .constant(.loading), style: .solid()) {} builder: {
                    Text("Loading...")
                }.frame(width: 200, height: 40)

                AppButton(state: .constant(.disabled), style: .solid()) {} builder: {
                    Text("Disabled")
                }.frame(width: 200, height: 40)

            }
            .padding()
        }
    }

    static var previews: some View {
        Group {
            PreviewWrapper()
                .previewDisplayName("Light Mode")
            
            PreviewWrapper()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}

struct AppButton<Content: View>: View {
    
    @Binding var state: ButtonState
    let style: buttonStyle
    var action: () -> () = {}
    let content: Content
    
    public init(
        state: Binding<ButtonState>,
        style: buttonStyle = .solid(),
        action: @escaping () -> Void,
        @ViewBuilder builder: () -> Content
    ) {
        self._state = state
        self.style = style
        self.action = action
        self.content = builder()
    }
    
    // MARK: - Derived Properties
    private var styleConfig: ButtonStyleConfig {
        style.styleConfig
    }

    private var isDisabled: Bool { state == .disabled }
    private var isLoading: Bool { state == .loading }

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Group {
                switch style {
                case .stroke, .solid:
                    strokeAndSolidContentView
                default:
                    plainContentView
                }
            }
            .contentShape(Rectangle()) // ensure full clickable area
        }
        .disabled(isDisabled || isLoading)
        .animation(.easeInOut, value: state)
    }

    // MARK: - Stroke & Solid Views
    private var strokeAndSolidContentView: some View {
        ZStack {
                backgroundView
                    .clipped()
            if isLoading {
                ProgressView()
                    .padding(10)
            } else {
                content
                    .foregroundColor(isDisabled ? styleConfig.disabledForegroundColor : styleConfig.foregroundColor)
                    .padding(styleConfig.paddingValue)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Plain Style
    @ViewBuilder private var plainContentView: some View {
        switch state {
        case .normal:
            content
                .foregroundColor(.blue)
        case .loading:
            ProgressView()
                .frame(height: 30)
                .aspectRatio(1, contentMode: .fit)
        case .disabled:
            content
                .foregroundColor(styleConfig.disabledForegroundColor)
        }
    }

    // MARK: - Background View
    @ViewBuilder private var backgroundView: some View {
        switch styleConfig.cornerStyle {
        case .ellipse:
            Capsule()
                .strokeBorder(isDisabled ? styleConfig.disableStrokeColor : styleConfig.borderColor, lineWidth: styleConfig.borderWidth)
                .background(Capsule().fill(isDisabled ? styleConfig.disabledBackgroundColor : styleConfig.backgroundColor))
        case .cornerRadius(let radius):
            RoundedRectangle(cornerRadius: radius)
                .strokeBorder(isDisabled ? styleConfig.disableStrokeColor : styleConfig.borderColor, lineWidth: styleConfig.borderWidth)
                .background(RoundedRectangle(cornerRadius: radius).fill(isDisabled ? styleConfig.disabledBackgroundColor : styleConfig.backgroundColor))
        case .rectangle:
            Rectangle()
                .strokeBorder(isDisabled ? styleConfig.disableStrokeColor : styleConfig.borderColor, lineWidth: styleConfig.borderWidth)
                .background(Rectangle().fill(isDisabled ? styleConfig.disabledBackgroundColor : styleConfig.backgroundColor))
        }
    }
}
enum ButtonState {
    case normal
    case disabled
    case loading
}



struct ButtonStyleConfig {
    // Button Style
    public var foregroundColor: Color
    public var backgroundColor: Color
    public var cornerStyle: CornerStyle
    public var paddingValue: CGFloat = 12
    
    // Stroke Style
    public var borderColor: Color
    public var borderWidth: CGFloat
    
    // Loading View Style
    public var loaderColor: Color = .red
    public var loaderStrokeWidth: CGFloat = 5
    
    // Disable Style
    public var disabledForegroundColor: Color
    public var disabledBackgroundColor: Color
    public var disableStrokeColor: Color
}

enum CornerStyle {
    case ellipse
    case cornerRadius(radius: CGFloat)
    case rectangle
}

enum buttonStyle {
    case stroke(primaryColor: Color = .blue,paddingValue: CGFloat = 12)
    case solid(textColor: Color = .white, backgroundColor: Color = .blue,paddingValue: CGFloat = 12)
    case plain
    case custom(config: ButtonStyleConfig)
}

extension buttonStyle {
    var styleConfig: ButtonStyleConfig {
        switch self {
        case .stroke(let primaryColor,let paddingValue):
            return ButtonStyleConfig(
                foregroundColor: primaryColor,
                backgroundColor: .clear,
                cornerStyle: .cornerRadius(radius: 10),
                paddingValue: paddingValue,
                borderColor: primaryColor,
                borderWidth: 1,
                disabledForegroundColor: .gray,
                disabledBackgroundColor: .clear,
                disableStrokeColor: .gray
            )
            
        case .solid(let textColor, let backgroundColor,let paddingValue):
            return ButtonStyleConfig(
                foregroundColor: textColor,
                backgroundColor: backgroundColor,
                cornerStyle: .cornerRadius(radius: 10),
                paddingValue: paddingValue,
                borderColor: .clear,
                borderWidth: 0,
                disabledForegroundColor: textColor,
                disabledBackgroundColor: .gray,
                disableStrokeColor: .clear
            )
            
        case .plain:
            return ButtonStyleConfig(
                foregroundColor: .blue,
                backgroundColor: .clear,
                cornerStyle: .ellipse,
                borderColor: .clear,
                borderWidth: 0,
                disabledForegroundColor:.blue,
                disabledBackgroundColor: .clear,
                disableStrokeColor: .clear
            )
        case .custom(config: let config):
            return config
            
        }}
}


