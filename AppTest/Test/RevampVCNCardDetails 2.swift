//
//  RevampVCNCardDetails.swift
//  VodafoneSwiftuiTest
//
//  Created by Vodafone on 20/04/2026.
//

import SwiftUI

struct RevampVCNCardDetails2: View {
    var body: some View {
        VStack{
            CardView2(
                cardNumber: "1234 5678 9012 3456",
                cardHolder: "AHMED MOHAMED",
                expiryDate: "12/28",
                cvv: "123"
            )
            //.frame(height: 200)
            .padding()
        }
    }
}

#Preview {
    RevampVCNCardDetails2()
        .environment(\.layoutDirection, .rightToLeft)
}


struct CardView2: View {
    let imageURL: String = ""
    let cardNumber: String
    let cardHolder: String
    let expiryDate: String
    let cvv: String
    
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .topLeading) {
//                // Background card image from API
//                
//                Image("card")
//                .frame(width: geometry.size.width, height: geometry.size.height)
//                
//                // Card Number (big rectangle in middle-left)
//                Text(cardNumber)
//                    .font(.system(size: geometry.size.width * 0.06, weight: .semibold, design: .monospaced))
//                    .foregroundColor(.white)
//                    .position(
//                        x: geometry.size.width * 0.32,  // ~32% from left
//                        y: geometry.size.height * 0.40  // ~40% from top
//                    )
//                
//                // Top-right small rectangle (maybe chip indicator text)
//                Text("DEBIT")
//                    .font(.system(size: geometry.size.width * 0.03, weight: .bold))
//                    .foregroundColor(.white)
//                    .position(
//                        x: geometry.size.width * 0.72,
//                        y: geometry.size.height * 0.13
//                    )
//                
//                // Card Holder (bottom-middle rectangle)
//                Text(cardHolder)
//                    .font(.system(size: geometry.size.width * 0.035, weight: .medium))
//                    .foregroundColor(.white)
//                    .position(
//                        x: geometry.size.width * 0.68,
//                        y: geometry.size.height * 0.72
//                    )
//                
//                // Expiry (bottom-right rectangle)
//                Text(expiryDate)
//                    .font(.system(size: geometry.size.width * 0.035, weight: .medium))
//                    .foregroundColor(.white)
//                    .position(
//                        x: geometry.size.width * 0.85,
//                        y: geometry.size.height * 0.72
//                    )
//            }
//        }
//        .aspectRatio(314/180, contentMode: .fit)  // lock card aspect ratio
//    }
    var body: some View {
        
        VStack{
            Text("500")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top,25)
                .padding(.trailing,60)
               
            Spacer()
            
            HStack{
                Text(cardNumber)
                    .foregroundColor(.white)
                Spacer()
                Text("copy")
                    .foregroundColor(.white)
                    
            }
            .padding(.horizontal,30)
            
            Spacer()

            HStack{
                Text("cardHolder")
                    .foregroundColor(.white)
                 
                Spacer()
                
                Text(expiryDate)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 20)
            .padding(.horizontal ,30)
 
        }
        .environment(\.layoutDirection, .leftToRight)
        .frame(maxWidth: .infinity)
        .aspectRatio(314/177, contentMode: .fit)
        .background {
            Image("card2")
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(314/177, contentMode: .fill)
        }
       
//        ZStack(alignment: .topLeading) {
//            // Background card image from API
//            
//            Image("card2")
//                .resizable()
//                .frame(maxWidth: .infinity)
//                .aspectRatio(314/177, contentMode: .fit)
//            
//            // Card Number (big rectangle in middle-left)
//            HStack{
//                Text(cardNumber)
//                    .foregroundColor(.white)
//                    .position(x: 120, y: 110)
//                
//                Spacer()
//                
//                Text("copy")
//                    .foregroundColor(.white)
//                    .padding(.horizontal,10)
//            }
//           
//          
//           
//            
//            // Top-right small rectangle (maybe chip indicator text)
//            Text("500")
//                .foregroundColor(.white)
//                .position(x: 290, y: 35)
//            
//            // Card Holder (bottom-middle rectangle)
//            Text(cardHolder)
//                .foregroundColor(.white)
//                .position(x: 215, y: 130)
//            
//            // Expiry (bottom-right rectangle)
//            Text(expiryDate)
//                .foregroundColor(.white)
//                .position(x: 270, y: 130)
//        }
//        .environment(\.layoutDirection, .leftToRight)
//        .frame(maxWidth: .infinity)
//        .aspectRatio(314/177, contentMode: .fit)

    }
}
