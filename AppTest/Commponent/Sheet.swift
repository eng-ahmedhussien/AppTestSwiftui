//
//  Sheet.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 24/12/2024.
//

import SwiftUI

struct Sheet: View {
    @State var showSheet = false
    @State var text = ""
    var body: some View {
        Button("sheet", action: {
            showSheet.toggle()
        })
        .sheet(isPresented: $showSheet, content: {
            TextField("Type something", text: $text, axis: .vertical)
                .frame(height: 200)
                .border(.red)
                .presentationDetents([.height(300)])
                .presentationCornerRadius(20)
                .presentationDragIndicator(.visible)
                .presentationBackground(.white)
        })
    }
}

#Preview {
    Sheet()
}
