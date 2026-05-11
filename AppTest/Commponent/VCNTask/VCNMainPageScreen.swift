//
//  VCNRevampScreen.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 09/02/2026.
//

import SwiftUI

struct VCNMainPageScreen: View {
    let model = VCNNavigationCardModel()
    // MARK: - Body
    var body: some View {
        VStack{
            ZStack{
                Image("AppIconeLight")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                VStack{
                    Text("tetst card")
                }
            }
            .appCard()
            
            Spacer()
            
            VStack{
                Text("tetst card")
                
            }.background {
                Image("AppIconeLight")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .appCard()
            }
            
            Spacer()
 
        }
    }
    
    private var backgroundImgeContentMode: UIView.ContentMode {
        model.cardStyle == .multiUse ?   .scaleAspectFit :   .scaleToFill
    }
    
}

#Preview {
    VCNMainPageScreen()
}

enum VCNNavigationCardStyle {
    case multiUse
    case singleUse
}

struct VCNNavigationCardModel {
    var title: String?
    var desc: String?
    var backgroundImgUrl: String?
    var btnTitle: String?
    var action: (() -> Void)?
    var cardStyle: VCNNavigationCardStyle = .singleUse
}
