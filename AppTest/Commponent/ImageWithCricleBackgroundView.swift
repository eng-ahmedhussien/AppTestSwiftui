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
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth - 30, height: imageHeight - 30)
                .padding(5)
                .foregroundStyle(.white)
        
        }
        
        .onTapGesture {
            onClick()
        } 
    }
    
}

#Preview {
    ImageWithCricleBackgroundView(color: .blue,
                                  imageHeight: 100,
                                  imageWidth: 100,
                                  onClick: {})
}

