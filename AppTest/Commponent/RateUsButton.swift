//
//  RateUsButton.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 11/08/2025.
//


import SwiftUI
import StoreKit

struct RateUsButton: View {
    @Environment(\.requestReview) private var requestReview
    
    var body: some View {
        Button("Rate the app") {
            
            requestReview()
        }
    }
}


#Preview{
    RateUsButton()
}

