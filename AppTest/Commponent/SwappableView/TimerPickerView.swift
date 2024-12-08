//
//  SwappingTextView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 19/08/2024.
//


import SwiftUI
import Combine

struct TimerPickerView: View {
    @State private var selectedValue: String = ""
    @State private var timerCancellable: AnyCancellable?
    
    let values = ["Apple", "Banana", "Cherry", "Date", "Elderberry"] // Example array of strings
    
    var body: some View {
        VStack{
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


