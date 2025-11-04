//
//  AppTestApp.swift
//  AppTest
//
//  Created by ahmed hussien on 13/03/2024.
//

import SwiftUI
import MijickNavigattie

@main
struct AppTestApp: App {
    @StateObject private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            RateUsButton()
        }
    }
}



