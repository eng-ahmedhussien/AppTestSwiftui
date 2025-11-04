//
//  NavigationBarModifier.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 11/04/2025.
//

import SwiftUI
import UIKit

//MARK: custom navigation bar ViewModifier
struct NavigationBarModifier: ViewModifier {
    init(backgroundColor: UIColor = .systemBackground, foregroundColor: UIColor = .blue, tintColor: UIColor?, withSeparator: Bool = true){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.backgroundColor = backgroundColor
        if withSeparator {
            navBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

#Preview {
    NavigationStack {
        Text("My Text Text")
            .navigationTitle("Test title")
            .navigationBarModifier(
                backgroundColor: .systemRed,
                foregroundColor: .white,
                tintColor: nil,
                withSeparator: true
            )
    }
}

extension View {
    func navigationBarModifier(backgroundColor: UIColor = .systemBackground, foregroundColor: UIColor = .label, tintColor: UIColor?, withSeparator: Bool) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, withSeparator: withSeparator))
    }
}

//MARK: other emplimentation

struct Privewer_AppNavigationBarStyle: View {
    var body: some View {
        NavigationStack {
            Text("tsext")
                .appNavigationBar(title: "test screen")
        }
    }
}

struct AppNavigationBarStyle : ViewModifier {
    var title: String = ""
    
    func body(content: Content) -> some View {
            content
            .navigationTitle(title.localized())
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.red)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
extension View {
    func appNavigationBar(title: String) -> some View {
        self
            .modifier(AppNavigationBarStyle(title: title))
    }
}

#Preview {
    Privewer_AppNavigationBarStyle()
}
