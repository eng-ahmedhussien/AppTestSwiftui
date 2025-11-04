//
//  SelectableList.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 07/08/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedIds: [UUID] = []
    private let items: [IdentifiableItem] = [
        IdentifiableItem(id: UUID(), title: "Item 1"),
        IdentifiableItem(id: UUID(), title: "Item 2"),
        IdentifiableItem(id: UUID(), title: "Item 3")
    ]

    var body: some View {
        Form {
            Selectables(items, selectedIds: $selectedIds) { item, isSelected in
                Text(item.title)
                    .font(.title)
                    .foregroundColor(isSelected.wrappedValue ? .green : .primary)
                    .onTapGesture {
                        isSelected.wrappedValue.toggle()
                    }
            }
        }
    }
}

struct IdentifiableItem: Identifiable {
    let id: UUID
    let title: String
}

#Preview(body: {
    ContentView()
})

#Preview(body: {
    ContentView1()
})

struct ContentView1: View {
    @State private var selectedIds: [UUID] = []
    private let items: [Item] = [
        Item(id: UUID(), title: "Item 1"),
        Item(id: UUID(), title: "Item 2"),
        Item(id: UUID(), title: "Item 3")
    ]

    var body: some View {
        List {
            Selectables(items, selectedIds: $selectedIds, id: \.id) { item, isSelected in
                HStack {
                    Text(item.title)
                        .font(.title)
                    Spacer()
                    Toggle("", isOn: isSelected)
                        .labelsHidden()
                }.padding()
            }
        }
    }
}

struct Item {
    let id: UUID
    let title: String
}

struct Selectables<Data, ID: Hashable, Content>: View where Content: View {
    let data: [Data]
    @Binding var selectedIds: [ID]
    let id: KeyPath<Data, ID>
    let content: (Data, Binding<Bool>) -> Content

    init(
        _ data: [Data],
        selectedIds: Binding<[ID]>,
        id: KeyPath<Data, ID>,
        @ViewBuilder content: @escaping (Data, Binding<Bool>) -> Content
    ) {
        self.data = data
        self._selectedIds = selectedIds
        self.id = id
        self.content = content
    }

    var body: some View {
        ForEach(data.indices, id: \.self) { index in
            self.content(self.data[index], Binding(
                get: { self.selectedIds.contains(self.data[index][keyPath: self.id]) },
                set: { isSelected in
                    if isSelected {
                        self.selectedIds.append(self.data[index][keyPath: self.id])
                    } else {
                        self.selectedIds.removeAll(where: { $0 == self.data[index][keyPath: self.id] })
                    }
                }
            ))
        }
        
    }
}

extension Selectables where ID == Data.ID, Data: Identifiable {
    init(
        _ data: [Data],
        selectedIds: Binding<[ID]>,
        @ViewBuilder content: @escaping (Data, Binding<Bool>) -> Content
    ) {
        self.init(
            data,
            selectedIds: selectedIds,
            id: \Data.id, content: content
        )
    }
}
