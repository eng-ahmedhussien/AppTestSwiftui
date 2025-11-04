//
//  ButtonWithEnums.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 31/05/2025.
//

import SwiftUI

//enum ButtonKind {
//    typealias ComponentColor = (
//        background: Color,
//        title: Color,
//        border: Color
//    )
//    
//     typealias StateColor = (
//        regular: Color,
//        disabled: Color,
//        pressed: Color
//    )
//    
//    case blue, red, gray, whiteBordered
//    case custom(
//           background: StateColor,
//           title: StateColor,
//           border: StateColor,
//           cornerRadius: CGFloat = 12,
//           height: CGFloat = 44,
//           font: Font = .body
//       )
//}
//// cornerRadius - height - font
//extension ButtonKind {
//    var cornerRadius: CGFloat {
//        switch self {
//        case .blue, .red, .gray, .whiteBordered: 12
//        case .custom(_, _, _, let cornerRadius, _, _): cornerRadius
//        }
//    }
//    
//    var height: CGFloat {
//        switch self {
//        case .blue, .red, .gray: 44
//        case .whiteBordered: 50
//        case .custom(_, _, _, _, let height, _): height
//        }
//    }
//    
//    var font: Font {
//        switch self {
//        case .blue, .red, .gray: .body
//        case .whiteBordered: .callout
//        case .custom(_, _, _, _, _, let font): font
//               
//        }
//    }
//}
//
//// titleColor - backgroundColor - borderColor
//extension ButtonKind {
//    private var titleColor: StateColor {
//        switch self {
//        case .blue, .red:
//            (.white, .white, .white)
//        case .gray:
//            (.black, .black.opacity(0.5), .black.opacity(0.5))
//        case .whiteBordered:
//            (.black, .black.opacity(0.5), .black.opacity(0.5))
//        case .custom(_, let title, _, _, _, _):
//                    title
//        }
//    }
//    
//    private var backgroundColor: StateColor {
//        switch self {
//        case .blue:
//            (.blue, .blue.opacity(0.5), .blue.opacity(0.5))
//        case .red:
//            (.red, .red.opacity(0.5), .red.opacity(0.5))
//        case .gray:
//            (.gray, .gray.opacity(0.5), .gray.opacity(0.5))
//        case .whiteBordered:
//            (.white, .white, .white)
//        case .custom(let background, _, _, _, _, _):
//                   background
//        }
//    }
//    
//    private var borderColor: StateColor {
//        switch self {
//        case .blue, .red, .gray:
//            (.clear, .clear, .clear)
//        case .whiteBordered:
//            (.black, .black.opacity(0.5), .black.opacity(0.5))
//        case .custom(_, _, let border, _, _, _):
//                   border
//        }
//    }
//    
//    func componentColor(isPressed: Bool, isEnabled: Bool) -> ComponentColor {
//        (
//            backgroundColor(isPressed: isPressed, isEnabled: isEnabled),
//            titleColor(isPressed: isPressed, isEnabled: isEnabled),
//            borderColor(isPressed: isPressed, isEnabled: isEnabled)
//        )
//    }
//}
//
//
//extension ButtonKind {
//    private func backgroundColor(isPressed: Bool, isEnabled: Bool) -> Color {
//        if isPressed {
//            self.backgroundColor.pressed
//        } else if !isEnabled {
//            self.backgroundColor.disabled
//        } else {
//            self.backgroundColor.regular
//        }
//    }
//    
//    private func titleColor(isPressed: Bool, isEnabled: Bool) -> Color {
//        if isPressed {
//            self.titleColor.pressed
//        } else if !isEnabled {
//            self.titleColor.disabled
//        } else {
//            self.titleColor.regular
//        }
//    }
//    
//    private func borderColor(isPressed: Bool, isEnabled: Bool) -> Color {
//        if isPressed {
//            self.borderColor.pressed
//        } else if !isEnabled {
//            self.borderColor.disabled
//        } else {
//            self.borderColor.regular
//        }
//    }
//}
//
//
//extension Button {
//    func style(_ kind: ButtonKind) -> some View {
//        buttonStyle(CcustomButtonStyle(kind))
//    }
//}
//
//private struct CcustomButtonStyle: ButtonStyle {
//    @Environment(\.isEnabled) var isEnabled
//    
//    private let kind: ButtonKind
//    
//    init(_ kind: ButtonKind) {
//        self.kind = kind
//    }
//    
//    func makeBody(configuration: Configuration) -> some View {
//        let color = kind.componentColor(
//            isPressed: configuration.isPressed,
//            isEnabled: isEnabled
//        )
//        
//        return configuration.label
//            .padding()
//            .foregroundStyle(color.title)
//            .font(kind.font)
//            .frame(height: kind.height)
//            .frame(maxWidth: .infinity)
//            .background(
//                color.background,
//                in: RoundedRectangle(cornerRadius: kind.cornerRadius)
//            )
//            .background(
//                RoundedRectangle(cornerRadius: kind.cornerRadius)
//                .stroke(
//                    color.border,
//                    lineWidth: 2
//                )
//            )
//    }
//}
//
//#Preview(body: {
//    @Previewable @State var isDisabled = false
//    
//    Section {
//            Button("Tap Me") {
//                // Action
//            }
//            .style(.gray)
//            .disabled(isDisabled)
//            
//            Button("Tap Me") {
//                // Action
//            }
//            .style(.red)
//            .disabled(isDisabled)
//            
//            Button("Tap Me") {
//                // Action
//            }
//            .style(.whiteBordered)
//            .disabled(isDisabled)
//        
//        Button("Custom") {}
//            .style(.custom(
//                background: (.green, .green.opacity(0.5), .green.opacity(0.7)),
//                title: (.white, .gray, .black),
//                border: (.yellow, .yellow.opacity(0.5), .yellow.opacity(0.7)),
//                cornerRadius: 20,
//                height: 50,
//                font: .headline
//            )).disabled(isDisabled)
//        
//        } header: {
//            Toggle("**disable**", isOn: $isDisabled)
//        }
//        .padding()
//    
//})
