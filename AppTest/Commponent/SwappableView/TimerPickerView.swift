//
//  SwappingTextView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 19/08/2024.
//


import SwiftUI
import Combine

//struct ContentView10: View {
//    let sampleTextArray = ["First", "Second", "Third", "Fourth"]
//    @State private var timer: Timer?
//    @State private var currentIndex = 0
//    
//    var body: some View {
//        
//    VStack{
//            ForEach(0..<sampleTextArray.count, id: \.self) { index in
//                if index == currentIndex {
//                    SwappingTextView(text: sampleTextArray[index])
//                        .transition(.opacity) // Adds a slide transition
//                }
//            }
//        }
//        .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        .border(.blue)
//        .animation(.easeInOut(duration: 0.5), value: currentIndex) // Smooth animation
//        .onAppear {
//            startTimer()
//        }
//        .onDisappear {
//            stopTimer()
//        }
//    }
//    
//    func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
//            withAnimation {
//                currentIndex = (currentIndex + 1) % sampleTextArray.count
//            }
//        }
//    }
//
//    func stopTimer() {
//        timer?.invalidate()
//    }
//}
//
//struct SwappingTextView: View {
//    let text: String
//    
//    var body: some View {
//        Text(text)
//            .font(.largeTitle)
//            .padding()
//    }
//}
//struct ContentView10_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView10()
//    }



//struct SwappingTextView: View {
//    let textArray: [String]
//    @State private var currentIndex = 0
//    @State private var isFadedOut = false
//    @State private var timer: Timer?
//
//    var body: some View {
//        HStack{
//            Image(systemName: "square.and.arrow.up.circle.fill")
//            Text(textArray[currentIndex])
//        }
//        .font(.largeTitle)
//        .padding()
//        .offset(y: isFadedOut ? -60 : 0)
//        //.opacity(isFadedOut ? 0 : 1)
//       // .animation(.smooth)
//        .onAppear {
//            startTimer()
//        }
//        .onDisappear {
//            stopTimer()
//        }
//        .border(.black)
//        .clipped()
//    }
//
//    func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//           withAnimation {
//                isFadedOut = true
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                currentIndex = (currentIndex + 1) % textArray.count
//              //  withAnimation {
//                    isFadedOut = false
//              //  }
//            }
//        }
//    }
//
//    func stopTimer() {
//        timer?.invalidate()
//    }
//}
//
//struct ContentView10: View {
//    let sampleTextArray = ["First", "Second", "Third", "Fourth"]
//
//    var body: some View {
//        SwappingTextView(textArray: sampleTextArray)
//    }
//}
//
//struct ContentView10_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView10()
//    }
//}


struct TimerPickerView: View {
    @State private var selectedValue: String = ""
    @State private var timerCancellable: AnyCancellable?
    
    let values = ["Apple", "Banana", "Cherry", "Date", "Elderberry"] // Example array of strings
    
    var body: some View {
        VStack{
            Text("advarlbnstfnblkmsbdfmdlkanfsfkmab")
                .padding()
            Picker("Select a Value", selection: $selectedValue) {
                ForEach(values, id: \.self) { value in
                    HStack{
                        Image(systemName: "square.and.arrow.up.circle.fill")
                        Text(value).tag(value)
                        
                    }
                }
            }
            .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .pickerStyle(WheelPickerStyle())
            .clipped()
            .animation(.easeOut(duration: 2), value: selectedValue)
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }
    
    func startTimer() {
        timerCancellable = Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if let currentIndex = values.firstIndex(of: selectedValue) {
                    // Move to the next value, and wrap around if at the end
                    withAnimation{
                        selectedValue = values[(currentIndex + 1) % values.count]
                    }
                } else {
                    // If no value is selected (e.g., first load), select the first one
                        selectedValue = values.first ?? ""
                }
            }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
    }
}

struct TimerPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerPickerView()
    }
}


