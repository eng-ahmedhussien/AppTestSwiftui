//
//  NavigationLinke.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 20/05/2024.
//

import SwiftUI

struct NavigationLinke: View {
  @State private var selectedItem: String? = nil
  @State private var showDetails = false

  enum MyData: String, Hashable {
    case item1
    case item2
  }

  var body: some View {
    NavigationStack {
      List {
        NavigationLink("Item 1", value: MyData.item1)
        NavigationLink("Item 2", value: MyData.item2)
          NavigationLink("Item 3", destination: {
              Text("Details for item3")
          })
      }
     
      .navigationDestination(for: MyData.self) { data in
        Text("Details for \(data.rawValue)")
      }
      .navigationDestination(item: $selectedItem) { data in
        Text("Selected item details: \(data)")
      }
      Button("Show Modal") {
        showDetails.toggle()
      }
        Button("select") {
            selectedItem = "asd"
        }
      .navigationDestination(isPresented: $showDetails) {
        Text("This is a modal view")
      }
    }
   
  }
}

#Preview{
    NavigationLinke()
}
