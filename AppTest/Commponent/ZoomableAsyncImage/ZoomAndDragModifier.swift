//
//  ZoomAndDragModifier.swift
//  AppTestSwiftui
//
//  Created by dbs on 20/10/2025.
//



struct ZoomAndDragModifier: ViewModifier {
    // Scaling
    @State private var scale: CGFloat = 1.0
    @State private var baseScale: CGFloat = 1.0
    let minScale: CGFloat
    let maxScale: CGFloat
    
    // Dragging
    @State private var offset: CGSize = .zero
    @State private var startOffset: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = CGSize(
                            width: startOffset.width + value.translation.width,
                            height: startOffset.height + value.translation.height
                        )
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
                    .onEnded { _ in
                        baseScale = scale
                    }
            )
            .animation(.easeInOut(duration: 0.15), value: scale)
    }
}

extension View {
    /// Apply drag + pinch-to-zoom with clamped scaling.
    /// - Parameters:
    ///   - minScale: Minimum allowed scale (default 1.0)
    ///   - maxScale: Maximum allowed scale (default 4.0)
    func zoomAndDrag(minScale: CGFloat = 1.0, maxScale: CGFloat = 4.0) -> some View {
        modifier(ZoomAndDragModifier(minScale: minScale, maxScale: maxScale))
    }
}
