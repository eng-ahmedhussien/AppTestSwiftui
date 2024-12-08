//
//  SwappableView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 02/12/2024.
//

import SwiftUI


struct ContentView10: View {
    let sampleTextArray = ["😃😃 First", "Second", "Third", "Fourth"]

    var body: some View {
        SwappableView(textArray: sampleTextArray)
    }
}

struct SwappableView: View {
    let textArray: [String]
    @State private var currentIndex = 0
    @State private var isTextVisible = true
    @State private var offset: CGFloat = 0
    @State private var timer: Timer?

    var body: some View {
            HStack{
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .padding(5)
                Text(textArray[currentIndex])
                    .font(.title)
                    .padding(5)
            }
        .offset(y: offset)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
       // .border(.red)
        .clipped()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            withAnimation(.easeOut(duration: 1)) {
                offset = -50 // Move text out of the screen to the left
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                currentIndex = (currentIndex + 1) % textArray.count
                offset = 0 // Reset to start from the bottom within bounds
                withAnimation (.easeOut(duration: 1)){
                    offset = 0 // Bring the text back to the center
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
}


#Preview{
        ContentView10()
}

