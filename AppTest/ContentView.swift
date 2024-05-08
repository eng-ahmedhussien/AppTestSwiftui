//
//  ContentView.swift
//  AppTest
//
//  Created by ahmed hussien on 13/03/2024.
//

import SwiftUI
import MijickNavigattie

struct ContentView: NavigatableView {
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

#Preview {
    ContentView()
        .preferredColorScheme(.light)
        .frame(width: 280, height: 350)
        .padding()
}





