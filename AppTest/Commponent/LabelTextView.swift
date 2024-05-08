//
//  LabelTextView.swift
//  AppTest
//
//  Created by ahmed hussien on 29/04/2024.
//

import SwiftUI
struct LabelTextView: View {
    var label: String
    var placeHolder: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(placeHolder, text: $text)
                .padding(.all)
                .background(.gray)
                .cornerRadius(5.0)
        }
    }
}

#Preview{
    LabelTextView(label: "asd", placeHolder: "place", text: .constant("a"))
}
