//
//  NavigationBarView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 11/04/2025.
//

import SwiftUI

//MARK: custom navigation bar
struct NavigationBar<Title: View, Leading: View, Trailing: View>: View {
    
    // MARK: - Init
    
    init(@ViewBuilder title: () -> Title, leading: () -> Leading = { EmptyView() }, trailing: () -> Trailing = { EmptyView() }) {
        self.title = title()
        self.leading = leading()
        self.trailing = trailing()
    }
    
    // MARK: - Properties
    
    var title: Title
    var leading: Leading
    var trailing: Trailing
    
    // MARK: - Properties (View)
    
    var body: some View {
        ZStack {
            Color.red
            HStack(spacing: 0) {
                leading.padding()
                Spacer()
                trailing.padding()
            }
            HStack {
                title.padding()
            }
        }
        .foregroundStyle(Color.black)
        .frame(height: 50)
    }
    
}



#Preview {
    NavigationStack{
        VStack{
            NavigationBar {
                Text("My App")
            } leading: {
                Button(action: {
                   // dismiss()
                }) { Image(systemName: "star") }
            } trailing: {
                Button(action: {}) { Image(systemName: "gear") }
            }
            
            Spacer()
            
            Text("test")
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}
