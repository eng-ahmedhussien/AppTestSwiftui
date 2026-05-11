//
//  VFPagingView.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 04/02/2026.
//


import SwiftUI

/// A view that displays a collection of views that the user can swipe through.
public struct VFPagingView<Content: View>: View {
    let pageCount: Int
    let content: (Int) -> Content
    let pageIndicator: Bool
    let autoScrollInterval: TimeInterval
    @State private var currentPage: Int = 0
    @State private var tabViewHeight: CGFloat = 100
    @State private var contentSize: CGSize = CGSize(width: 0, height: 100)
    @State private var timer: Timer?
    
    private var autoScrollEnabled: Bool { pageCount > 1 && autoScrollInterval > 0}
    
    /// Creates a new instance that generates views based on the given parameters.
    /// - Parameters:
    ///  - pageCount: The number of pages in the view.
    ///  - pageIndicator: A Boolean value that indicates whether the page indicator is shown.
    ///  - autoScrollInterval: The time interval between automatic page transitions default is 0.
    ///  - content: A view builder that creates the content of each page.
    public init(pageCount: Int,
         pageIndicator: Bool = true,
         autoScrollInterval: TimeInterval = 0,
         @ViewBuilder content: @escaping (Int) -> Content) {
        self.pageCount = pageCount
        self.content = content
        self.pageIndicator = pageIndicator
        self.autoScrollInterval = autoScrollInterval
    }
    
    public var body: some View {
        VStack {
            mainView
            pager
        }
    }
    
    private var mainView: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pageCount, id: \.self) { index in
                content(index)
                    .saveSize(in: $contentSize)
            }
        }
        .frame(height: contentSize.height)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear {
            guard autoScrollEnabled else { return }
            startAutoScroll()
        }
        .onDisappear {
            guard autoScrollEnabled else { return }
            timer?.invalidate()
        }
    }
    
    @ViewBuilder
    private var pager: some View {
        if pageIndicator && pageCount > 1 {
            VFPagger(pages: pageCount, selectedPage: currentPage)
            .padding(.top, 5)
        }
    }
}

// MARK: - Auto Scroll
extension VFPagingView {
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: autoScrollInterval, repeats: true) { timer in
            withAnimation {
                currentPage = (currentPage + 1) % pageCount
            }
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        Text("VFPagingView Demo")
            .font(.title)
            .padding()
        
        // Example 1: Basic paging view with page indicator
        VStack(alignment: .leading, spacing: 8) {
            Text("Basic Paging View (3 pages)")
                .font(.headline)
            
            VFPagingView(pageCount: 3, autoScrollInterval: 3) { index in
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue.opacity(0.3))
                        .frame(height: 120)
                        .overlay(
                            VStack {
                                Text("Page \(index + 1)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Text("Swipe to navigate")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        )
                    
                    Text("This is page \(index + 1) content")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
            }
            .frame(height: 200)
            .border(.black)
        }
        
        // Example 3: Paging view without page indicator
        VStack(alignment: .leading, spacing: 8) {
            Text("Paging View without Indicator (3 pages)")
                .font(.headline)
            
            VFPagingView(pageCount: 3,pageIndicator: false) { index in
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Feature \(index + 1)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("Description of feature \(index + 1) and its benefits")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.orange.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "star.fill")
                                .font(.title2)
                                .foregroundColor(.orange)
                        )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
            }
            .frame(height: 120)
        }
        
        Spacer()
    }
    .padding()
}
