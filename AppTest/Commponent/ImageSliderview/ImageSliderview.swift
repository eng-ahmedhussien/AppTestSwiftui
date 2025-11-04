//
//  ImageSlider.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 21/05/2025.
//


import SwiftUI
 
// Usage
struct ImageSliderContentView: View {
    @Environment(\.layoutDirection) var layoutDirection
    
    let originalUrls = [
        URL(string: "https://picsum.photos/seed/picsum/200/300")!,
        URL(string: "https://picsum.photos/200/300?grayscale")!
    ]
    
    @State private var currentIndex: Int = 0

    var body: some View {
        let isRTL = layoutDirection == .rightToLeft
        let urls = isRTL ? originalUrls.reversed() : originalUrls

        VStack {
            ACarousel(urls, id: \.self,
                      index: $currentIndex,
                      spacing: 10,
                      headspace: 0,
                      sidesScaling: 0.8,
                      isWrap: true,
                      autoScroll: .active(5)) { url in

                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .cornerRadius(10)
                } placeholder: {
                    Image("logoPlaceholder")
                }

            }

            HStack(spacing: 8) {
                ForEach(0..<urls.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? .yellow : .gray)
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut, value: currentIndex)
                }
            }
            .padding(.top, 8)
        }
        .frame(height: 200)
    }
}


#Preview{
    ImageSliderContentView()
        .environment(\.layoutDirection, .rightToLeft)
}
