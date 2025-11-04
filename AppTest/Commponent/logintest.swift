//
//  logintest.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 18/06/2025.
//

import SwiftUI

struct logintest: View {
    var body: some View {
            ZStack {
                VStack {
                    Color.appprimary
                        .frame(height: 500)
                    Spacer()
                }
                .ignoresSafeArea()

                VStack(alignment: .center) {
                    TextField("asd", text: .constant(""))
                    TextField("asd", text: .constant(""))
                    TextField("asd", text: .constant(""))
                    TextField("asd", text: .constant(""))
                }
                .frame(height: 400)
                .background(.white)
                .appCornerRadius(20, corners: [.topLeft,.topRight])
                .ignoresSafeArea()
            }
        }
}

#Preview {
    //logintest()
    ColoredTopWithRoundedBottomView()
}


// MARK: - specify specific corners
struct AppCornerRidius: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
extension View {
    func appCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: AppCornerRidius(radius: radius, corners: corners))
    }
}



struct ColoredTopWithRoundedBottomView: View {
    var topColor: Color = .blue
    var bottomColor: Color = .green
    var body: some View {
           ZStack(alignment: .top) {
               // Top full-width rectangle
               Rectangle()
                   .fill(topColor)
                   //.frame(height: 200)
                   .edgesIgnoringSafeArea(.top)
               
               // Bottom rectangle: narrower and with rounded top corners
               Rectangle()
                   .fill(bottomColor)
                   .frame( height: 600)
                   .appCornerRadius(40, corners: [.topLeft, .topRight])
                   .offset(y: 180) // Slightly overlap the top rectangle
            
           }
           .ignoresSafeArea(edges: .bottom)
       }     
}

