// MagicButtonView.swift
// Copyright (c) 2024 Submap

import Combine
import SwiftUI

private var cancellables = Set<AnyCancellable>()

struct MagicButtonView: View {
    var action: () -> Void

    @Environment(\.chatGPT) var chatGPT
    @Environment(\.audio) var audio
    @Environment(\.speech) var speech

    @State private var progress = 0.0
    @State private var timer: Timer?
    @State private var isDragging = false

    @Binding var textPrompt: String

    @FocusState var keyboardFocused: Bool

    var body: some View {
        ZStack {
            ProgressView(value: progress, total: 100)
                .animation(isDragging ? .linear : .spring(.bouncy(duration: 0.1)), value: progress)
                .progressViewStyle(AudioProgressStyle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            guard !isDragging else { return }
                            self.isDragging = true
                            startProgress()
                        }
                        .onEnded { _ in
                            self.isDragging = false
                            stopProgress()
                        }
                )
            Image(systemName: "brain.fill")
        }
        .disabled(audio.recorder == nil ? true : false)
        .opacity(audio.recorder == nil ? 0.6 : 1.0)
        .frame(height: 48)
        .shadow(radius: 4)
    }

    private func startProgress() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            withAnimation {
                self.progress += 1
                if self.progress > 100 {
                    self.progress = 100
                    stopProgress()
                }
            }
        }
        DispatchQueue.main.async {
            audio.record()
        }
    }

    private func stopProgress() {
        timer?.invalidate()
        withAnimation {
            self.progress = 0
        }

        keyboardFocused = false
        audio.stopRecording()

        audio.audioURLSubject
            .sink { url in
                self.speech.recognizeSpeech(url: url)
            }
            .store(in: &cancellables)

        speech.transcriptionSubject
            .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
            .sink { value in
                self.textPrompt = value
                
                self.action()
            }
            .store(in: &cancellables)
    }
}

#Preview {
    MagicButtonView(action: {}, textPrompt: .constant(""), keyboardFocused: .init())
}
