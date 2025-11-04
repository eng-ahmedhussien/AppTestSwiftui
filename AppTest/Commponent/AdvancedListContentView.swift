//
//  ContentView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 22/05/2025.
//


import SwiftUI
import AdvancedList

struct AdvancedListContentView: View {
    @State private var listState: ListState = .items
    @State private var items: [String] = ["ahmed","hussien","mohammed","mohammden"]
    @State private var currentPage = 1
    private let itemsPerPage = 20

    var body: some View {
        VStack{
            AdvancedList(items, listView: { rows in
                    ScrollView {
                        LazyVStack(alignment: .leading, content: rows)
                            .padding()
                    }.scrollBounceBehavior(.basedOnSize)
               
            }, content: { item in
                HStack{
                    Text(item)
                        .padding()
                    Spacer()
                }
                    .border(.red)
            }, listState: listState, emptyStateView: {
                Text("No data")
            }, errorStateView: { error in
                Text(error.localizedDescription)
                    .lineLimit(nil)
            }, loadingStateView: {
                Text("Loading ...")
            })
        }
    }

//    private func loadInitialData() {
//        listState = .loading
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            items = Array((1...itemsPerPage)).map { "Item \($0)" }
//            listState = items.isEmpty ? .empty : .items
//        }
//    }
//
//    private func loadMoreItems() {
//         // Simulate loading more items
//        listState = .loading
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let newItems = Array(((currentPage * itemsPerPage) + 1)...((currentPage + 1) * itemsPerPage)).map { "Item \($0)" }
//            items.append(contentsOf: newItems)
//            currentPage += 1
//            listState = .items
//        }
//    }
}
#Preview {
    AdvancedListContentView()
}

extension String: Identifiable {
    public var id: String {
        return self
    }
}
