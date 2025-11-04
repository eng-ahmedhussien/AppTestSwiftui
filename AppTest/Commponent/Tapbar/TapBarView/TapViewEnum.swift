//
//  TapViewEnum.swift
//  AllinOnApp
//
//  Created by ahmed hussien on 10/03/2025.
//

import SwiftUI


enum TapViewEnum : Identifiable, CaseIterable, View {
    
    case  home, orders, profile
    var id: Self { self }
    
    var tabItem : TabItem {
        switch self {
        case .home:
                .init(image: "homeTap", title: "home")
        case .orders:
                .init(image: "ordersTap", title: "orders")
        case .profile:
                .init(image: "profileTap", title: "profile")
        }
    }
    
    var body: some View {
        switch self {
        case .home:
            Text("home")
        case .orders:
            Text("orders")
        case .profile:
            Text("profile")
        }
    }
}

     

#Preview {
    TapViewEnum.home.body
}
