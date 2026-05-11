//
//  cardAlinm.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 22/04/2026.
//
import SwiftUI

struct cardAlinm: View {

    var body: some View {
        HStack(spacing: 10){
            termsAndDetailsView
            DeleteCardView
        }
        .padding()
        
    }
    
    private var termsAndDetailsView: some View {
        Button(action: {
            print(123)
        }) {
            
            VStack {
                Image(systemName: "square.and.arrow.up.circle")
                
                Text("الشروط والاستفسارات والمزيد")
                  
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 2)


        }
    }
        
        private var DeleteCardView: some View {
            Button(action: {
                print(123)
            }) {
                
                VStack {
                    Image(systemName: "square.and.arrow.up.circle")
                    
                    Text("مسح الكارد")
                }
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 2)
            }
            
        }
        

}

#Preview {
    cardAlinm()
        .environment(\.layoutDirection, .rightToLeft)
}


