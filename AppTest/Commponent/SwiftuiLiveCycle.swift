//
//  SwiftuiLiveCycle.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 15/08/2024.
//

import SwiftUI

struct View1: View {
    var body: some View {
        Text("View1")
            .onAppear{
                print("onAppear in View1")
            }
            .onDisappear{
                print("onDisappear in View1")
            }
    }
}

struct View2: View {
    var body: some View {
        Text("View2")
            .onAppear{
                print("onAppear in View2")
            }
            .onDisappear{
                print("onDisappear in View2")
            }
    }
}

struct SwiftuiLiveCycle: View {
    var body: some View {
        TabView {
            NavigationView{
                NavigationLink(destination: View1()) {
                    Text("Next")
                }
            }.onAppear{
                print("onAppear in ContentView")
            }
            .onDisappear{
                print("onDisappear in ContentView")
            }
            
            .tabItem {
                Image(systemName:
                        "viewfinder.circle.fill")
                Text("ContentView")
            }
            
            View2()
                .tabItem {
                    Image(systemName: "camera.viewfinder")
                    Text("View2")
                }
        }
        .onAppear{
            print("onAppear in TabView")
        }
        .onDisappear{
            print("onDisappear in TabView")
        }
    }
}
