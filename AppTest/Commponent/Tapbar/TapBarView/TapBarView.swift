//
//  TapBarView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 21/04/2025.
//

import SwiftUI

struct TapBarView: View {

    @State var selectTap : TapViewEnum = .home
    
    init() {
        setupTapViewAppearance()
    }
    
    var body: some View {
        TabView (selection:$selectTap){
            ForEach(TapViewEnum.allCases){ tab in
                let tabItem = tab.tabItem
                tab
                    .tabItem {
                        VStack(spacing: 10){
                            Image(tabItem.image)
                                .renderingMode(.template)
                                  
                            Text(tabItem.title)
                        }
                    }
                    .tag(tab)
            }
        }
        .accentColor(.red)
    }
    
    private func setupTapViewAppearance() {
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 5),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.05).cgColor
            ]
        )
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowImage = image
        
        // 🛠 Customize title font here (UIKit level)
        let normalTapTitle = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        let selectedTapTitle = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalTapTitle
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedTapTitle
        
        // 👇 Adjust vertical spacing between image and title
        // Move the title downward
//        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
//        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        
        // Move the icon upward
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        ///change icon color
       /// appearance.stackedLayoutAppearance.normal.iconColor = .black
        ///appearance.stackedLayoutAppearance.selected.iconColor = .red
    }
}

#Preview {
    TapBarView()
}


extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
