//
//  RevampVCNCardDetails.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 15/03/2026.
//

import SwiftUI

struct RevampVCNCardDetails: View {
    
    let cardNumber = "7746 - 8013 - 7466 - 5482"
    let amount = "EGP 500"
    let cvv = "123"
    let expiry = "12/26"
    
    var body: some View {

        VStack{
            AmountPillView(amount: amount)
                .alignHorizontally(.trailing,40)
            
            Spacer()
            
            HStack(spacing: 10) {
                CardNumberView(cardNumber: cardNumber)
                CopyButtonView(cardNumber: cardNumber)
            }

            Spacer()
            
            HStack {
                CVVExpiryView(cvv: cvv, expiry: expiry)
                Spacer()
                ManageButtonView()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
        .frame(width: 314, height: 177)
        .background {
            Image("card")
        }
        .border(.red)
    }
}

#Preview {
    RevampVCNCardDetails()
}


// MARK: - Amount Pill
struct AmountPillView: View {
    let amount: String
    
    var body: some View {
        Text(amount)
            .padding()
            .foregroundColor(.white)

    }
}


// MARK: - Card Number
struct CardNumberView: View {
    let cardNumber: String
    
    var body: some View {
        Text(cardNumber)
            .foregroundColor(.white)
            .fixedSize(horizontal: true, vertical: false)
    }
}

// MARK: - Copy Button
struct CopyButtonView: View {
    let cardNumber: String
    @State private var copied = false
    
    var body: some View {
        Button {
            UIPasteboard.general.string = cardNumber.replacingOccurrences(of: " - ", with: "")
            withAnimation { copied = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { copied = false }
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: copied ? "checkmark" : "doc.on.doc")
                    .font(.system(size: 12))
                Text(copied ? "Copied" : "Copy")
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(.white)
        }
    }
}

// MARK: - CVV & Expiry
struct CVVExpiryView: View {
    let cvv: String
    let expiry: String
    
    var body: some View {
        Text("CVV \(cvv)     exp \(expiry)")
            .font(.system(size: 12))
            .foregroundColor(.white)
    }
}

// MARK: - Manage Button
struct ManageButtonView: View {
    var body: some View {
        Button {
            // Navigate to manage screen
        } label: {
            HStack(spacing: 4) {
                Text("Manage")
                    .font(.system(size: 13, weight: .medium))
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundColor(.white)
        }
    }
}

