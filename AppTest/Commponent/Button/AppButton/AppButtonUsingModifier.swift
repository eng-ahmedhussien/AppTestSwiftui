//
//  ButtonStyleExtentions.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 13/04/2025.
//

import SwiftUI



struct AppButtonUsingModifier: ViewModifier {
    
    let kind: ButtonKind
    let width: CGFloat?
    let hight: CGFloat?
    let disabled: Bool
    
    init(kind: ButtonKind = .solid, width: CGFloat? = nil,hight: CGFloat? = nil ,disabled: Bool = false) {
        self.kind = kind
        self.width = width
        self.hight = hight
        self.disabled = disabled
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: width,height: hight)
            .font(.body)
            .foregroundColor(foregroundColor)
            .padding()
            .background(backgroundView())
            .cornerRadius(kind == .solid ? 10 : 0)
            .disabled(disabled)
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
    
    @ViewBuilder private func backgroundView() -> some View {
        switch kind {
        case .solid:
            Capsule()
                .strokeBorder(disabled ? .gray : .clear, lineWidth: 1)
                .background(disabled ? Color.gray : Color.red)
        case .border:
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(disabled ? .gray.opacity(0.8) : .red, lineWidth: 1)
        case .plain:
            EmptyView()
        }
    }
}

extension View {
    func buttonStyle(_ kind: ButtonKind, width: CGFloat? = nil,hight: CGFloat? = nil ,disabled: Bool = false) -> some View {
        modifier(AppButtonUsingModifier(kind: kind, width: width, hight: hight,disabled: disabled))
    }
}

#Preview{
    @Previewable @State var isDisabled = false
    VStack{
        
        Toggle("**disable**", isOn: $isDisabled).padding()
        List{
            Section{
               
                Button {
                    print("solid")
                } label: {
                    Text("Solid")
                        .buttonStyle(.solid, width: 120, disabled: isDisabled)
                }
                
                Text("Solid")
                    .buttonStyle(.solid,hight: 5, disabled: isDisabled)
            }header: {
                Text("Solid").padding()
            }
            
            Section{
                Text("Border")
                    .buttonStyle(.border, width: 120, disabled: isDisabled)
                Text("Border")
                    .buttonStyle(.border, width: 120, disabled: isDisabled)
            }
            header: {
                Text("Border").padding()
            }
            
            Section{

                Button {
                    print("Plain")
                } label: {
                    Text("Plain")
                        .buttonStyle(.plain, disabled: isDisabled)
                }
                
                Text("Plain")
                    .buttonStyle(.plain, disabled: isDisabled)
            }header: {
                Text("Plain").padding()
            }
        }
    }
}
