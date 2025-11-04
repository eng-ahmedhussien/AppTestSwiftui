//
//  Waveanimation.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 19/12/2024.
//

import SwiftUI



struct WaveAnimation: View {
    var body: some View {
        ZStack{
            ForEach(0 ..< 5) { index in
                let waveRadius = CGFloat(index*50)
                SingleWave()
                    .frame(width: waveRadius, height: waveRadius)
            }
        }
    }
}


struct SingleWave: View {
    @State private var isAnimating: Bool = false
    var body: some View {
        ZStack {
            Circle()
                //.stroke(.black,lineWidth: 2)
                .fill(.red)
                .scaleEffect(isAnimating ? 1 : 0)
                .opacity(isAnimating ? 0 : 1)
                .animation(.linear(duration: 1).repeatForever(autoreverses: false).speed(0.5),value: isAnimating)
        }
        .onAppear(){
            isAnimating.toggle()
        }
    }
}



struct VoiceWaveView : View {
    @State private var isAnimating: Bool = false
    var body: some View {
        VStack{
            Image(systemName: "mic.circle.fill")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.red,.white)
                .background(WaveAnimation())
        }
        .frame(width: 200, height: 200)
        .background(.blue)
        
    }
}

#Preview {
    VoiceWaveView()
}
