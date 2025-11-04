//
//  ContentView.swift
//  AppTestSwiftui
//
//  Created by dbs on 20/10/2025.
//


import SwiftUI

struct ZoomableAsyncImage: View {
    
    let url: String
    //zoom
    @State private var scale: CGFloat = 1.0
    @State private var baseScale: CGFloat = 1.0
    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 4.0
    //Drag
    @State private var offset: CGSize = .zero
    @State private var startOffset: CGSize = .zero
    
    var body: some View {
        if let url = URL(string: url) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .offset(offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    offset = CGSize(width: startOffset.width + value.translation.width,
                                                    height: startOffset.height + value.translation.height)
                                }
                                .onEnded { _ in
                                    withAnimation(.spring) {
                                        offset = .zero
                                        startOffset = .zero
                                    }
                                }
                        )
                    
                        .scaledToFit()
                        .scaleEffect(scale)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let proposed = baseScale * value
                                    scale = min(max(proposed, minScale), maxScale)
                                }
                                .onEnded { value in
                                    baseScale = scale
                                }
                        )
                        .animation(.easeInOut(duration: 0.15), value: scale)
                        
                case .failure:
                    VStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        Text("Failed to load image")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .contentShape(Rectangle())
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            ProgressView()
        }
    }
}


//MARK: DragGesture demo
//struct ZoomableAsyncImage: View {
//
//    @State private var scale: CGFloat = 1.0
//    @State private var baseScale: CGFloat = 1.0
//    private let minScale: CGFloat = 1.0
//    private let maxScale: CGFloat = 4.0
//
//    @State private var offset: CGSize = .zero
//    @State private var startOffset: CGSize = .zero
//
//    var body: some View {
//        if let url = URL(string: "https://picsum.photos/id/237/200/300") {
//            AsyncImage(url: url) { phase in
//                switch phase {
//                case .empty:
//                    ProgressView()
//                case .success(let image):
//                    image
//                        .offgset(offset)
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    offset = CGSize(width: startOffset.width + value.translation.width,
//                                                    height: startOffset.height + value.translation.height)
//                                }
//                                .onEnded { _ in
//                                    // Commit final offset or snap back with animation
//                                    withAnimation(.spring) {
//                                        // Example: snap back
//                                        offset = .zero
//                                        startOffset = .zero
//                                    }
//                                }
//                        )
//                case .failure:
//                    VStack(spacing: 8) {
//                        Image(systemName: "exclamationmark.triangle")
//                            .font(.largeTitle)
//                        Text("Failed to load image")
//                            .font(.callout)
//                            .foregroundStyle(.secondary)
//                    }
//                    .contentShape(Rectangle())
//                @unknown default:
//                    EmptyView()
//                }
//            }
//        } else {
//            ProgressView()
//        }
//    }
//}
//

//MARK: zoom with min and max
//struct ZoomableAsyncImage: View {
//
//    @State private var scale: CGFloat = 1.0
//    @State private var baseScale: CGFloat = 1.0
//    private let minScale: CGFloat = 1.0
//    private let maxScale: CGFloat = 4.0
//
//    var body: some View {
//        if let url = URL(string: "https://picsum.photos/id/237/200/300") {
//            AsyncImage(url: url) { phase in
//                switch phase {
//                case .empty:
//                    ProgressView()
//                case .success(let image):
//                    image
//                        .scaledToFit()
//                        .scaleEffect(scale)
//                        .gesture(
//                            MagnificationGesture()
//                                .onChanged { value in
//                                    let proposed = baseScale * value
//                                    scale = min(max(proposed, minScale), maxScale)
//                                }
//                                .onEnded { value in
//                                    baseScale = scale
//                                }
//                        )
//                        .animation(.easeInOut(duration: 0.15), value: scale)
//                case .failure:
//                    VStack(spacing: 8) {
//                        Image(systemName: "exclamationmark.triangle")
//                            .font(.largeTitle)
//                        Text("Failed to load image")
//                            .font(.callout)
//                            .foregroundStyle(.secondary)
//                    }
//                    .contentShape(Rectangle())
//                @unknown default:
//                    EmptyView()
//                }
//            }
//        } else {
//            ProgressView()
//        }
//    }
//}


//MARK: zoom without min and max
//struct ZoomableAsyncImage: View {
//    @State private var scale: CGFloat = 1.0
//    var body: some View {
//        if let url = URL(string: "https://picsum.photos/id/237/200/300") {
//            AsyncImage(url: url) { phase in
//                switch phase {
//                case .empty:
//                    ProgressView()
//                case .success(let image):
//                    image
//                        .scaledToFit()
//                        .scaleEffect(scale)
//                        .gesture(
//                            MagnificationGesture()
//                                .onChanged { value in
//                                    self.scale = value.magnitude
//                                }
//                        )
//                case .failure:
//                    VStack(spacing: 8) {
//                        Image(systemName: "exclamationmark.triangle")
//                            .font(.largeTitle)
//                        Text("Failed to load image")
//                            .font(.callout)
//                            .foregroundStyle(.secondary)
//                    }
//                    .contentShape(Rectangle())
//                @unknown default:
//                    EmptyView()
//                }
//            }
//
//        }else{
//            ProgressView()
//        }
//    }
//}

#Preview {
    ZoomableAsyncImage(url:"https://picsum.photos/id/237/200/300")
}


