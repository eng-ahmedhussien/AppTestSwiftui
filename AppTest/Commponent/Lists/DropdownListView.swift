//
//  DropdownListView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 08/05/2025.
//


import SwiftUI




//struct DropdownListEx: View {
//    //@State private var selectedCityId: Int?
//    
//    let cities = [
//        City(id: 1, name: "Cairo"),
//        City(id: 2, name: "Alexandria"),
//        City(id: 3, name: "Giza"),
//        City(id: 4, name: "Cairo"),
//        City(id: 5, name: "Alexandria"),
//        City(id: 6, name: "Giza"),
//        City(id: 7, name: "Cairo"),
//        City(id: 8, name: "Alexandria"),
//        City(id: 9, name: "Giza"),
//        City(id: 10, name: "Cairo"),
//        City(id: 11, name: "Alexandria"),
//        City(id: 12, name: "Giza"),
//        City(id: 13, name: "Cairo"),
//        City(id: 14, name: "Alexandria"),
//        City(id: 15, name: "Giza"),
//        City(id: 16, name: "Cairo"),
//        City(id: 17, name: "Alexandria"),
//        City(id: 18, name: "Giza")
//    ]
//    
//    var body: some View {
//        DropdownListView(
//            options: cities,
//            getTitle: { $0.name }
//        )
//        .padding()
//    }
//}
//
//#Preview(body: {
//    DropdownListEx()
//})
//
//
//struct DropdownListView<T: Identifiable & Hashable>: View {
//    var selectedId: T
//    let options: [T]
//    let getTitle: (T) -> String
//    
//    @State private var isExpanded: Bool = false
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Button(action: {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }) {
//                HStack {
//                    Text(selectedId.)
//                        .foregroundColor(selectedId == nil ? .gray : .primary)
//                    Spacer()
//                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                }
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//            }
//
//            if isExpanded {
//                ScrollView{
//                    VStack(alignment: .leading, spacing: 0) {
//                        ForEach(options, id: \.self) { item in
//                            Button(action: {
//                                selectedId = item.id
//                                isExpanded = false
//                            }) {
//                                Text(getTitle(item))
//                                    .padding()
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .background(selectedId == item.id ? Color.blue.opacity(0.2) : Color.clear)
//                            }
//                            Divider()
//                        }
//                    }
//                }
//                .background(Color(.systemBackground))
//                .cornerRadius(8)
//                .shadow(radius: 2)
//            }
//        } .frame(height: 400)
//    }
//
//    private var selectedTitle: String {
//        if let id = selectedId,
//           let selectedItem = options.first(where: { $0.id == id }) {
//            return getTitle(selectedItem)
//        } else {
//            return "Select an option"
//        }
//    }
//}
//
////Identifiable gives each model a unique id.
////Hashable ensures the whole object can be used in sets, compared, or used in ForEach(id: .self).
//protocol DropdownItem: Identifiable, Hashable {
//    var name: String { get }
//}
//
//struct City: DropdownItem {
//    let id: Int
//    let name: String
//}
//
