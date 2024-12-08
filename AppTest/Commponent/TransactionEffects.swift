//
//  TransactionEffects.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 03/12/2024.
//

import SwiftUI


struct PreviewPage : View {
    var body: some View {
        VStack(spacing: 20){
            TransactionEffects()
            
            Transaction1()
            
            Transaction2()
        }
    }
}

struct TransactionEffects : View {
    let sampleTextArray = ["😃😃 First", "Second", "Third", "Fourth"]
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .padding(5)
                Text(sampleTextArray[currentIndex])
                    .font(.title)
                    .padding(5)
            }
            .id(currentIndex)
            .transition(.asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            ))
        }
        .padding()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .animation(.easeInOut(duration: 0.5), value: currentIndex)
        .clipped()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % sampleTextArray.count
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
}

struct Transaction1 : View {
    let sampleTextArray : [String] = ["😃😃 First", "Second", "Third", "Fourth"]
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .padding(5)
                Text(sampleTextArray[currentIndex])
                    .font(.title)
                    .padding(5)
            }
            .id(currentIndex)
            .transition(.asymmetric(insertion: .move(edge: .bottom), removal:  .move(edge: .top)))
        }
        .padding()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .animation(.easeInOut(duration: 0.5), value: currentIndex)
        .clipped()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % sampleTextArray.count
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
}

struct Transaction2 : View {
    let sampleTextArray : [String] = ["😃😃 First", "Second", "Third", "Fourth"]
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .padding(5)
                Text(sampleTextArray[currentIndex])
                    .font(.title)
                    .padding(5)
            }
            .id(currentIndex)
            .transition(.asymmetric(insertion: .move(edge: .bottom),removal: .scale))
        }
        .padding()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .animation(.easeInOut(duration: 0.5), value: currentIndex)
        .clipped()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % sampleTextArray.count
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
}

#Preview{
    PreviewPage()
}

