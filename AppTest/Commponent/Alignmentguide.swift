//
//  Alignmentguide.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 06/03/2026.
//
import SwiftUI

struct AlignmentguideScreen: View {
    
    var body: some View {
        
        
        Text("Buy Now")
            .padding()
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue.gradient)
            }
            .overlay(alignment: .topTrailing) {
                Text("9")
                    .alignmentGuide(.top) { dim in
                        dim.height / 2
                    }
                    .alignmentGuide(.trailing) { dim in
                        dim.width / 2
                    }
            }
    }
}

#Preview {
    AlignmentguideScreen()
}
