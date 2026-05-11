//
//  RevampVCNCardDetails.swift
//  VodafoneSwiftuiTest
//
//  Created by Vodafone on 20/04/2026.
//

import SwiftUI

struct RevampVCNCardDetails: View {
    var body: some View {
        VStack{
            CardView(
                imageURL: "https://.../card-bg.png",
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
    RevampVCNCardDetails()
}


struct CardView: View {
    let imageURL: String = ""
    let cardNumber: String
    let cardHolder: String
    let expiryDate: String
    let cvv: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // Background card image from API
                
                Image("Group 145068")
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Card Number (big rectangle in middle-left)
                Text(cardNumber)
                    .font(.system(size: geometry.size.width * 0.06, weight: .semibold, design: .monospaced))
                    .foregroundColor(.white)
                    .position(
                        x: geometry.size.width * 0.32,  // ~32% from left
                        y: geometry.size.height * 0.40  // ~40% from top
                    )
                
                // Top-right small rectangle (maybe chip indicator text)
                Text("DEBIT")
                    .font(.system(size: geometry.size.width * 0.03, weight: .bold))
                    .foregroundColor(.white)
                    .position(
                        x: geometry.size.width * 0.72,
                        y: geometry.size.height * 0.13
                    )
                
                // Card Holder (bottom-middle rectangle)
                Text(cardHolder)
                    .font(.system(size: geometry.size.width * 0.035, weight: .medium))
                    .foregroundColor(.white)
                    .position(
                        x: geometry.size.width * 0.68,
                        y: geometry.size.height * 0.72
                    )
                
                // Expiry (bottom-right rectangle)
                Text(expiryDate)
                    .font(.system(size: geometry.size.width * 0.035, weight: .medium))
                    .foregroundColor(.white)
                    .position(
                        x: geometry.size.width * 0.85,
                        y: geometry.size.height * 0.72
                    )
            }
        }
        .aspectRatio(314/180, contentMode: .fit)  // lock card aspect ratio
    }
}
