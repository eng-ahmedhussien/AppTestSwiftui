//
//  CollapsibleView.swift
//  AppTest
//
//  Created by ahmed hussien on 17/03/2024.
//

import SwiftUI
import MijickNavigattie

struct showView: NavigatableView{
    @State var isExpanded = false
    var body: some View {
        CollapsibleView()
//        VStack {
//            CollapsibleCombonent("Expandable Row") {
//                Text("This is the collapsed content.")
//                    .padding()
//                    .background(Color.yellow)
//            }
//            
//            CollapsibleCombonent2("Expandable Row",
//                            expandedContent: {
//                Text("This is the expanded content.")
//                    .padding()
//                    .background(Color.green)
//            },
//                            foldedContent: {
//                Text("This is the folded content.")
//                    .padding()
//                    .background(Color.yellow)
//            })
          

            // Add more CollapsibleViews as needed
       // }
    }
}

#Preview {
    showView()
}
struct CollapsibleCombonent<Content: View>: View {
    private let label: String
    private let content: Content
    @State private var isExpanded = false

    init(_ label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
    }

    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                content
            }
        }
    }
}
struct CollapsibleCombonent2<ExpandedContent: View, FoldedContent: View>: View {
    private let label: String
    private let expandedContent: ExpandedContent
    private let foldedContent: FoldedContent
    @State private var isExpanded = false

    init(_ label: String, @ViewBuilder expandedContent: () -> ExpandedContent, @ViewBuilder foldedContent: () -> FoldedContent) {
        self.label = label
        self.expandedContent = expandedContent()
        self.foldedContent = foldedContent()
    }

    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                expandedContent
            } else {
                foldedContent
            }
        }
    }
}




struct CollapsibleView: View {
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Folded view (first image)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Wallet balance")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("120.00 SAR")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    HStack(spacing: 4) {
                        Text("Top up")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.primary)
                    }
                }
            }
            
            // Expanded view (second image)
            if isExpanded {
                VStack(alignment: .leading, spacing: 16) {
//                    Text("Wallet balance")
//                        .font(.headline)
//                        .foregroundColor(.primary)
//                    Text("120.00 SAR")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.primary)

                    HStack {
                        TextField("Enter amount", text: .constant(""))
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                        
                        Image(systemName: "banknote")
                            .foregroundColor(.secondary)
                            .padding(.trailing)
                    }
                    
                    Button(action: {
                        // Handle send credit action
                    }) {
                        Text("Send credit")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primary)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
               // .transition(.move(edge: .top).combined(with: .offset(y: 250))) // Smooth transition
                .padding(.top, 16)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding()
    }
}
