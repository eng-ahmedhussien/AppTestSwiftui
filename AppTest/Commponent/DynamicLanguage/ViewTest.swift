//
//  ViewTest.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 17/03/2025.
//

import SwiftUI

struct ViewTest: View {
    @EnvironmentObject var localizableManager: LocalizableManager
    
    var body: some View {
        VStack {
            Button("Change Language") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            
            TabView {
                Text("HomeView()")
                    .tabItem {
                        VStack {
                            Image(systemName: "heart.fill")
                            Text("home".localized())
                        }
                    }
                
                Text("AddWordsView()")
                    .tabItem {
                        VStack {
                            Image(systemName: "heart.fill")
                            Text("add.words".localized())
                        }
                    }
                
                Text("ProgressView()")
                    .tabItem {
                        VStack {
                            Image(systemName: "heart.fill")
                            Text("progress".localized())
                        }
                    }
                
                SettingsView()
                    .tabItem {
                        VStack {
                            Image(systemName: "heart.fill")
                            Text("settings".localized())
                        }
                    }
            }
            .id(localizableManager.currentLanguage)
        } // Force TabView reload
    }
}

#Preview {
    ViewTest()
        .environmentObject(LocalizableManager.shared)

}


struct SettingsView: View {
    @EnvironmentObject var localizableManager: LocalizableManager
    
    var body: some View {
        Menu {
            ForEach(LanguageTypes.allCases, id: \.self) { language in
                Button {
                    localizableManager.currentLanguage = language
                } label: {
                    Text(language.name)
                }
            }
        } label: {
            Label(localizableManager.localize("language"), systemImage: "globe")
        }
    }
}
