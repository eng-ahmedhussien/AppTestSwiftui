//
//  gridView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 03/12/2025.
//

import SwiftUI

struct gridView: View {
    
    private var data  = Array(1...3)
    
    private let fixedColumn = [
        GridItem(.fixed(168)),
        GridItem(.fixed(168))
    ]
    
    @State var selected : Int = 0
    
    var body: some View {
        VStack{
            LazyVGrid(columns: fixedColumn, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    HStack{
                        Image(systemName: "phone")
                        Text(String(item))
                        
                    }
                        .foregroundColor(.black)
                        .font(.title)
                        .frame(width: 168, height: 62, alignment: .center)
                        .cardBackground(cornerRadius: 25, shadowRadius: 8, shadowColor: .black.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(selected == item ? Color.yellow : Color.clear, lineWidth: 3)
                        )
                        
                        .onTapGesture{
                            selected = item
                        }
                        
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    gridView()
}
