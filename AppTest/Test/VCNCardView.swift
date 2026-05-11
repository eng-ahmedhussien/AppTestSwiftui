//
//  VCNCardView.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 21/03/2026.
//
import SwiftUI

struct VCNCardView2: View {

    var body: some View {
        VStack{
            ForEach(1...3, id: \.self) {_ in
                VCNCardView{
                    print(123)
                }
            }
        }
        .padding()
        
    }
}

struct VCNCardView: View {

    let onTap: () -> Void
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 6)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("**** **** **** *1234")
                    .font(.system(size: 18))
                
                Text("Valid till 02/09/2015")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 16)
            .padding(.vertical, 20)
            
            Spacer()
            
            // Arrow indicator
            Image(systemName: "chevron.right")
           // .frame(width: 14, height: 14)
            .padding(.trailing, 16)
        }
        .frame(height: 70)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.09), radius: 5)
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    VCNCardView2()
}
