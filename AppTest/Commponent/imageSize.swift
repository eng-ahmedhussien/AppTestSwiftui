//
//  imageSize.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 28/10/2024.
//


import SwiftUI

struct imageSize: View {
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)  // Set your desired aspect ratio
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()  // Optional padding for spacing
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
struct imageSize2: View {
    // Get screen width and height using UIScreen
       let screenWidth = UIScreen.main.bounds.width
       let screenHeight = UIScreen.main.bounds.height

       var body: some View {
           VStack {
               Image(systemName: "photo")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(height: screenHeight * 0.1)
                   // Here, 80% of the screen width and 40% of the screen height
                   .background(Color.gray.opacity(0.2)) // Optional background for reference
                   .cornerRadius(10)
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(Color.white) // Set background color for clarity
       }
}

#Preview {
    imageSize2()
}
