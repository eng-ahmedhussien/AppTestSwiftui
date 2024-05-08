//
//  TamaraBurronView.swift
//  AppTest
//
//  Created by ahmed hussien on 30/04/2024.
//

import SwiftUI

struct TamaraBurronView: View {
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Text("Split in 4 payment of\n SAR \(200). No interest\n No late fees.")
                    Image(systemName: "greaterthan")
                }
                .padding()
                .background(.gray.opacity(0.3))
                .cornerRadius(20)
                
                Image("tamara-logo-badge-en")
                    .resizable()
                    .frame(width:100,height: 30)
                    .offset(x:-50, y: -50)
            }
        }
    }
}

#Preview{
    TamaraBurronView()
}
