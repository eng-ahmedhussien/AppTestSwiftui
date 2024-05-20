//
//  SwiftUILayoutSystem.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 13/05/2024.
//

import SwiftUI

struct SwiftUILayoutSystem: View {
    var body: some View {
        VStack{
            Image(systemName: "calendar")
                .frame(width: 50, height: 50)
                .background(Color.red)
            
            Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .background(Color.red)
            
            Image(systemName: "calendar")
                       .resizable()
                       .frame(width: 50, height: 50)
                       .background(Color.red)
                       .padding()
        
            Image(systemName: "calendar")
                       .resizable()
                       .frame(width: 50, height: 50)
                       .background(Color.red)
                       .padding()
                       .background(Color.blue)
            
            Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.red)
            
            Image(systemName: "calendar")
                        .resizable()
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(Color.red)
            
            Image(systemName: "calendar")
                       .resizable()
                       .frame(width: 50, height: 50)
                       .padding()
                       .background(Color.red)
                       .cornerRadius(10)
                       .foregroundColor(.white)
        }
    }

}

#Preview {
    SwiftUILayoutSystem()
}
