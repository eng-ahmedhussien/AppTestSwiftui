//
//  ImageCarousel.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 10/11/2024.
//

import SwiftUI

fileprivate enum Colors: String, CaseIterable, Identifiable {
    case red
    case blue
    case orange
    case purple
    
    var id: UUID { UUID() }
    
    var color: Color {
        switch self {
        case .red:
            Color.red
        case .blue:
            Color.blue
        case .orange:
            Color.orange
        case .purple:
            Color.purple
        }
    }
}
//
struct ImageCarousel: View {
    
    @State var scrollPosition: Int?
    private let pageWidth: CGFloat = 350
    private let pageHeight: CGFloat = 200
    private let colors = Colors.allCases

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(0..<colors.count, id:\.self) { index in
                    let color = colors[index]
                    Text(color.rawValue)
                        .foregroundStyle(.black)
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: pageWidth, height: pageHeight)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(color.color)
                        )
                        .padding(.horizontal, (UIScreen.main.bounds.width - pageWidth)/2)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $scrollPosition)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)

    }
}


#Preview {
    ImageCarousel()
}
