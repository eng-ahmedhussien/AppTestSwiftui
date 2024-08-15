//
//  TapBar.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 15/08/2024.
//

import SwiftUI

struct TabBar: View {
    @State private var activeTab: Tab = .home


    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self, content: createButton)
        }
        .padding(.top, 12)
        .padding(.bottom, UIScreen.safeArea.bottom)
        .padding(.horizontal, 24)
        .ignoresSafeArea()
        .background(createBackground())
    }
}
private extension TabBar {
    func createButton(_ tab: Tab) -> some View {
        Button(action: { onButtonTap(tab) }) {
            VStack(spacing: 4) {
                createIcon(tab)
                createText(tab)
            }
            .foregroundColor(tab == activeTab ? .red : .gray)
        }
        .frame(maxWidth: .infinity)
    }
    func createBackground() -> some View {
        LinearGradient(stops: [
            .init(color: .black.opacity(0.72), location: 0),
            .init(color: .blue, location: 0.3)
        ], startPoint: .top, endPoint: .bottom)
    }
}
private extension TabBar {
    func createIcon(_ tab: Tab) -> some View {
        Image(tab.icon)
            .resizable()
            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    func createText(_ tab: Tab) -> some View {
        Text(tab.title).font(.title)
    }
}

private extension TabBar {
    func onButtonTap(_ tab: Tab) {
        activeTab = tab
    }
}


// MARK: - Tab
fileprivate enum Tab: CaseIterable { case home, search, saved }
private extension Tab {
    var icon: String { switch self {
        case .home: return "icon.fill.home"
        case .search: return "icon.search"
        case .saved: return "icon.bookmarks"
    }}
    var title: String { switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .saved: return "Saved"
    }}
}

#Preview{
    TabBar()
}
