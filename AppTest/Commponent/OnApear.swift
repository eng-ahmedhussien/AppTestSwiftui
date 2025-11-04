//
//  OnApear.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 12/02/2025.
//

import SwiftUI


struct FirstAppearView: View {
    @State private var greeting: String = "Initial"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(greeting)
                    .onTapGesture {
                        greeting = "Tapped"
                    }
                NavigationLink(destination: Text("Pushed Text")) {
                    Text("Push a View")
                }
                .padding()
            }
//            .onFirstAppear {
//                greeting = "On Appear"
//            }
            .onAppear {
                greeting = "On Appear"
            }
        }
    }
}

#Preview{
    FirstAppearView()
}


public extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(ViewFirstAppearModifier(perform: action))
    }
}

struct ViewFirstAppearModifier: ViewModifier {
    @State private var didAppearBefore = false
    private let action: () -> Void
    
    init(perform action: @escaping () -> Void) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard !didAppearBefore else { return }
            didAppearBefore = true
            action()
        }
    }
}
