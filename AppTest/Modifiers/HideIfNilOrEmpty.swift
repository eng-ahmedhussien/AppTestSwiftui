//
//  HideIfNilOrEmpty.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//

import SwiftUI

    // Modifier that hides a view based on a condition
struct HideIfNilOrEmpty: ViewModifier {
    var isHidden: Bool
    
    func body(content: Content) -> some View {
        Group {
            if !isHidden {
                content
            }
        }
    }
}

extension View {
        /// Hide view if optional is nil or String is empty
    func hideIfNil<T>(_ value: T?) -> some View {
        modifier(HideIfNilOrEmpty(isHidden: value == nil || (value as? String)?.isEmpty == true))
    }
}
