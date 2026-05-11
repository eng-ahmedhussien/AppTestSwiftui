//
//  singleView.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 18/02/2026.
//

import SwiftUI


struct SingleUseScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var spendingLimit: String = ""
    @FocusState private var isTextFieldFocused: Bool

      // MARK: - Constants
      private let minLimit: Double = 5
      private let maxLimit: Double = 30_000

      private var isIssueButtonEnabled: Bool {
          guard let value = Double(spendingLimit) else { return false }
          return value >= minLimit && value <= maxLimit
      }

    
    var body: some View {
        
        //MARK: padding
//        VStack(spacing: 0) {
//            Color.black.opacity(0.8)
//                .frame(height: UIScreen.main.bounds.height * 0.2)
//                .padding(.bottom, -20)
//            
//            Color.white
//                .cornerRadius(20, corners: [.topLeft, .topRight])
//        }
//        .overlay(alignment: .top) {
//            contentSection
//                .padding(.horizontal)
//                .padding(.top, UIScreen.main.bounds.height * 0.1 - 120 / 2)
//        }
        
        //MARK: offset
//        VStack(spacing: 0) {
//            Color.black.opacity(0.8)
//                .frame(height: UIScreen.main.bounds.height * 0.2)
//                .padding(.bottom, -20)
//            
//            Color.white
//                .cornerRadius(20, corners: [.topLeft, .topRight])
//                .overlay(alignment: .top) {
//                    contentSection
//                        .padding()
//                        .offset(y: -100)
//                }
//               
//        }
        
        //MARK: ZStack
//        ZStack(alignment: .center) {
//            VStack(spacing: 0) {
//                Color.black.opacity(0.8)
//                    .frame(height: UIScreen.main.bounds.height * 0.2)
//                    .padding(.bottom, -20)
//                
//                Color.white
//                    .cornerRadius(20, corners: [.topLeft, .topRight])
//            }
//            
//            VStack {
//                Spacer()
//                    .frame(height: UIScreen.main.bounds.height * 0.2 - 100)
//                
//                VStack{
//                    Text("test")
//                }
//                .frame(width: 344, height: 424)
//                .padding(.horizontal)
//                .border(.red)
//                .background(.blue)
//                   
//                Spacer()
//            }
//            .padding(.horizontal)
//        }
        
        //MARK: alignmentGuide
        VStack(spacing: 0) {
            Color.black.opacity(0.8)
                .frame(height: UIScreen.main.bounds.height * 0.2)
                .padding(.bottom, -20)
            
            Color.white
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .overlay(alignment: .top) {
                    VStack{
                        Text("test")
                    }
                    .frame(width: 344, height: 424)
                    .padding(.horizontal)
                    .border(.red)
                    .background(.blue)
                    .alignmentGuide(.top){ dim in
                        dim.height / 4
                        
                    }

                }
            
        }
        
    }
}



struct VCNHeaderCardModel{
    
    var title = ""
    var validity = ""
    var validityColor = UIColor.white
    var imgURL = ""
    var height:CGFloat?
}

#Preview {
    SingleUseScreen()
}



