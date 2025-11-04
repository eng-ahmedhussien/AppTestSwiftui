//
//  Grid.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 11/11/2024.
//

import SwiftUI

struct Grid: View {
    // Array of size options
    let sizes = ["75ml", "125ml", "250ml", "500ml", "750ml", "750ml", "500ml", "125ml"]
    
    // Selected size
    @State private var selectedSize: String? = "75ml"

    // Grid item layout
    let columns = [
        GridItem(.adaptive(minimum: 100)) // Adjust minimum to control the size
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Select size")
                .font(.headline)
                .padding(.leading)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(sizes, id: \.self) { size in
                    Text(size)
                        .frame(width: 70, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(10)
                        //.padding(.vertical, 10)
                        // .padding(.horizontal, 20)
                        .background(selectedSize == size ? Color.yellow : Color.gray.opacity(0.2))
                        .foregroundColor(selectedSize == size ? .black : .primary)
                        .clipShape(Capsule())
                        .onTapGesture {
                            selectedSize = size
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    Grid()
}

