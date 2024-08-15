//
//  ImageWithCricleBackgroundView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 17/07/2024.
//

import SwiftUI

struct ImageWithCricleBackgroundView: View {
    
    let color: Color
    var imageUrl: String?
    var placeholderImage: Image?
    let imageHeight: CGFloat
    let imageWidth: CGFloat
    let onClick: (() -> Void)
    
    var body: some View {
        ZStack {
            color
                .clipShape(Circle())
                .frame(width: imageWidth, height: imageHeight)
            Image(systemName: "square.and.arrow.up.circle.fill")
                .scaledToFill()
                .padding(5)
        }
        .onTapGesture {
            onClick()
        } 
    }
    
}

#Preview {
    ImageWithCricleBackgroundView(color: .gray,
                                  imageHeight: 40,
                                  imageWidth: 40,
                                  onClick: {})
}
