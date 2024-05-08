//
//  CollapsibleView.swift
//  AppTest
//
//  Created by ahmed hussien on 17/03/2024.
//

import SwiftUI
import MijickNavigattie

struct CollapsibleView: NavigatableView{
    @State var isExpanded = false
    var body: some View {
        VStack {
            CollapsibleCombonent("Expandable Row") {
                Text("This is the collapsed content.")
                    .padding()
                    .background(Color.yellow)
            }
            
            CollapsibleCombonent2("Expandable Row",
                            expandedContent: {
                Text("This is the expanded content.")
                    .padding()
                    .background(Color.green)
            },
                            foldedContent: {
                Text("This is the folded content.")
                    .padding()
                    .background(Color.yellow)
            })
          

            // Add more CollapsibleViews as needed
        }
    }
}

#Preview {
    CollapsibleView()
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

