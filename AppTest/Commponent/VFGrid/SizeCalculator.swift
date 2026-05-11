//
//  SizeCalculator.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 04/02/2026.
//


import SwiftUI

struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    
    init(size: Binding<CGSize>) {
        self._size = size
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader{ proxy in
                    Color.clear
                        .onAppear{
                            size = proxy.size
                        }
                        .onChange(of: proxy.size) { newSize in
                            size = newSize
                        }
                    
                }
            )
    }
}

extension View {
    /// Saves the size of the view into a given `CGSize` binding.
    ///
    /// This function applies the `SizeCalculator` modifier, which measures the view's size and updates the binding.
    ///
    /// - Parameter size: A binding to a `CGSize` that stores the view's calculated size.
    /// - Returns: A modified view that updates the given `size` binding.
    public func saveSize(in size: Binding<CGSize>) -> some View {
        return modifier(SizeCalculator(size: size))
    }    
}

#Preview {
    VStack(spacing: 20) {
        Text("Size Calculator Demo")
            .font(.title)
            .padding()
        
        SizeCalculatorDemoView()
    }
    .padding()
}

struct SizeCalculatorDemoView: View {
    @State private var textSize: CGSize = .zero
    @State private var rectangleSize: CGSize = .zero
    @State private var customViewSize: CGSize = .zero
    
    var body: some View {
        VStack(spacing: 20) {
            // Text with size calculation
            VStack(alignment: .leading, spacing: 8) {
                Text("Text Size Calculator")
                    .font(.headline)
                
                Text("This is a sample text that will have its size calculated")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                    .saveSize(in: $textSize)
                
                Text("Width: \(String(format: "%.1f", textSize.width))")
                    .font(.caption)
                Text("Height: \(String(format: "%.1f", textSize.height))")
                    .font(.caption)
            }
            
            Divider()
            
            // Rectangle with size calculation
            VStack(alignment: .leading, spacing: 8) {
                Text("Rectangle Size Calculator")
                    .font(.headline)
                
                Rectangle()
                    .fill(Color.orange.opacity(0.3))
                    .frame(width: 150, height: 60)
                    .saveSize(in: $rectangleSize)
                
                Text("Width: \(String(format: "%.1f", rectangleSize.width))")
                    .font(.caption)
                Text("Height: \(String(format: "%.1f", rectangleSize.height))")
                    .font(.caption)
            }
            
            Divider()
            
            // Custom view with size calculation
            VStack(alignment: .leading, spacing: 8) {
                Text("Custom View Size Calculator")
                    .font(.headline)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Custom View")
                        .font(.body)
                    Spacer()
                    VStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("Custom View")
                            .font(.body)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("Custom View")
                            .font(.body)
                    }
                }
                .padding()
                .background(Color.purple.opacity(0.2))
                .cornerRadius(12)
                .saveSize(in: $customViewSize)
                
                Text("Width: \(String(format: "%.1f", customViewSize.width))")
                    .font(.caption)
                Text("Height: \(String(format: "%.1f", customViewSize.height))")
                    .font(.caption)
            }
        }
    }
}
