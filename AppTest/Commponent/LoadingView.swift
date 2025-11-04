//
//  LoadingView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 20/04/2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var isLoading = true
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
               // .redacted(reason: .placeholder)
                .redacted(reason: isLoading ? .placeholder : [])
                .task {
                    await loadData()
                }
        }
    }
    
    func loadData() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isLoading = false
    }
}

#Preview {
    LoadingView()
}
