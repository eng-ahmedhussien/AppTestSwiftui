//
//  EnumOfShaps.swift
//  AppTest
//
//  Created by ahmed hussien on 26/03/2024.
//

import Foundation
import SwiftUI

// Define an enum for different shapes
enum CustomShape {
    case rectangle
    case circle
    case ellipse
    case roundedRectangle
    // Add more shapes as needed
}

struct ShapeView: View {
    let shape: CustomShape
    
    var body: some View {
        GeometryReader { geometry in
            self.shapeView(for: geometry.size)
        }
    }
    
    private func shapeView(for size: CGSize) -> some View {
        switch shape {
        case .rectangle:
            return AnyView(Rectangle().frame(width: size.width, height: size.height))
        case .circle:
            return AnyView(Circle().frame(width: size.width, height: size.height))
        case .ellipse:
            return AnyView(Ellipse().frame(width: size.width, height: size.height))
        case .roundedRectangle:
            return AnyView(RoundedRectangle(cornerRadius: 20).frame(width: size.width, height: size.height))
        }
    }
}

struct EnumOfShaps: View {
    @State private var selectedShape: CustomShape = .rectangle
    
    var body: some View {
        VStack {
            Picker("Select Shape", selection: $selectedShape) {
                Text("Rectangle").tag(CustomShape.rectangle)
                Text("Circle").tag(CustomShape.circle)
                Text("Ellipse").tag(CustomShape.ellipse)
                Text("Rounded Rectangle").tag(CustomShape.roundedRectangle)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ShapeView(shape: selectedShape)
                .foregroundColor(.blue) // Change the color of the shape as needed
                .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EnumOfShaps()
    }
}
