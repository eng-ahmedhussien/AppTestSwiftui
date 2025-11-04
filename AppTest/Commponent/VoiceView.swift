//
//  VoiceView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 19/12/2024.
//

import SwiftUI
import AVFoundation
import Speech

struct VoiceView: View {
    
    let detectVoice: (String) -> Void
    @State private var speechRecognizer: SpeechRecognizer?
    @State private var powerLevel: CGFloat = 0.0
    @State private var showWave = false
    
    var body: some View {
        VStack {
            if  showWave {
                WaveformView(powerLevel: powerLevel) // Add wave animation here
                    .frame(height: 80)
            }
            
            Text("Speck now")
                .font(.title2)
                .foregroundColor(.black)
                .padding(5)
                .onTapGesture {
                    showWave.toggle()
                    speechRecognizer = SpeechRecognizer(detectVoice: detectVoice) { level in
                        self.powerLevel = CGFloat(level)
                    }
                    speechRecognizer?.startRecording()
                }

            
            Text("Cancel")
                .font(.caption)
                .foregroundColor(.gray)
                .onTapGesture {
                    showWave.toggle()
                    speechRecognizer?.stopRecording()
                }
        }
//        .onAppear {
//            speechRecognizer = SpeechRecognizer(detectVoice: detectVoice) { level in
//                self.powerLevel = CGFloat(level)
//            }
//            speechRecognizer?.startRecording()
//        }
//        .onDisappear {
//            speechRecognizer?.stopRecording()
//        }
    }
}

// MARK: - WaveformView
struct WaveformView: View {
    let powerLevel: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let barCount = 25
            let spacing: CGFloat = 10
            let barWidth = (geometry.size.width - CGFloat(barCount - 1) * spacing) / CGFloat(barCount)
            
            HStack(spacing: spacing) {
                ForEach(0..<barCount, id: \.self) { index in
                    Capsule()
                        .fill(Color.blue.opacity(0.7))
                        .frame(
                            width: barWidth,
                            height: max(10, CGFloat.random(in: 0.3...1) * powerLevel * 200)
                        )
                }
            }
            .frame(height: geometry.size.height)
        }
    }
}

#Preview {
    VoiceView(detectVoice: { _ in })
}


class SpeechRecognizer {
    
    private var audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var speechRecognizer: SFSpeechRecognizer?
    private var currentTranscription: String?
    private var debounceTimer: Timer?
    private var detectVoiceClosure: ((String) -> Void)?
    private var powerLevelHandler: ((Float) -> Void)?

    init(detectVoice: @escaping (String) -> Void, powerLevelHandler: @escaping (Float) -> Void) {
        self.speechRecognizer = SFSpeechRecognizer()
        self.detectVoiceClosure = detectVoice
        self.powerLevelHandler = powerLevelHandler
    }

    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session setup failed: \(error)")
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        
        recognitionRequest?.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!) { result, error in
            if let result = result {
                self.currentTranscription = result.bestTranscription.formattedString
                self.resetDebounceTimer()
            }

            if error != nil || result?.isFinal == true {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionTask = nil
                self.debounceTimer?.invalidate()
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
            
            // Calculate audio power level
            let power = self.calculatePowerLevel(from: buffer)
            self.powerLevelHandler?(power)
        }

        audioEngine.prepare()

        do {
            try audioEngine.start()
        } catch {
            print("Audio engine couldn't start: \(error)")
        }
    }

    private func calculatePowerLevel(from buffer: AVAudioPCMBuffer) -> Float {
        guard let channelData = buffer.floatChannelData?[0] else { return 0.0 }
        let channelDataArray = Array(UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
        
        let power = channelDataArray.map { $0 * $0 }.reduce(0, +) / Float(buffer.frameLength)
        let powerLevel = 10 * log10(power)
        return max(0, min(1, (powerLevel + 50) / 50)) // Normalize between 0 and 1
    }

    private func resetDebounceTimer() {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(processTranscription), userInfo: nil, repeats: false)
    }

    @objc private func processTranscription() {
        if let transcription = currentTranscription {
            debugPrint("searchVM.searchSuggestionsText.text = \(transcription)")
            detectVoiceClosure?(transcription)
        }
    }

    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        recognitionTask = nil
        debounceTimer?.invalidate()
    }
}
