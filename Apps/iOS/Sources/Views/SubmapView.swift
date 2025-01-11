// SubmapView.swift
// Copyright (c) 2025 Submap

import SwiftUI

struct SubmapView: View {
    @Environment(\.chatGPT) var chatGPT
    @Environment(\.llama) var llama
    @Environment(\.location) var location
    @Environment(\.events) var events
    @Environment(\.camera) var camera
    @Environment(\.settings) var settings

    @FocusState private var keyboardFocused: Bool

    @State var textPrompt: String = ""
    @State private var isContactPickerPresented: Bool = false
    @State private var isResponsePresented: Bool = false
    @State private var isOnboardPresented: Bool = false

    var body: some View {
        MainHudView()
        .onAppear(perform: {
            if !location.isOn
                || !camera.isOn
            {
                isOnboardPresented = true
            }
            location.start()
        })
        .sheet(isPresented: $isResponsePresented, onDismiss: {
            chatGPT.reset()
            keyboardFocused = false
        }, content: {
            ResultView()
        })
        .fullScreenCover(isPresented: $isOnboardPresented, content: {
            SettingsView(isContactPickerPresented: $isContactPickerPresented)
        })
    }
    
    @ViewBuilder
    func MainHudView() -> some View {
        NavigationStack {
            CameraView()
                .overlay {
                    TextEditor(text: $textPrompt)
                        .fixedSize(horizontal: false, vertical: true)
                        .disabled(true)
                        .scrollContentBackground(.hidden)
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .focused($keyboardFocused)
                        .environment(\.colorScheme, .dark)
                        .shadow(radius: 4)
                }
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom) {
                            Button {
                                isOnboardPresented = true
                            } label: {
                                Image(systemName: "switch.2")
                            }.buttonStyle(MaterialButtonStyle(active: .constant(false)))

                            MagicButtonView(action: {
                                                let prompt = AIPrompt(user: textPrompt,
                                                                      location: location,
                                                                      events: events)
                                                switch settings.mlModel {
                                                case .llama: llama.prompt(prompt: prompt)
                                                case .chatGPT: chatGPT.prompt(prompt: prompt)
                                                }
                                                textPrompt = ""
                                                keyboardFocused = false
                                            },
                                            textPrompt: $textPrompt,
                                            keyboardFocused: _keyboardFocused)
                            Button {
                                withAnimation { keyboardFocused.toggle() }
                            } label: {
                                HStack {
                                    Image(systemName: "keyboard.fill")
                                    Image(systemName: "hand.draw.fill")
                                }
                            }.buttonStyle(MaterialButtonStyle(active: .constant(keyboardFocused)))
                            Button {} label: {
                                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                            }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
                        }.padding()
                        MapView()
                    }
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        let disable = textPrompt.isEmpty

                        Button {} label: {
                            Image(systemName: "eraser.fill")
                        }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
                            .disabled(disable)
                            .opacity(disable ? 0.0 : 1)
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        switch chatGPT.computeState {
                        case .idle, .error: EmptyView()
                        case .thinking: ProgressView().tint(.white).shadow(radius: 4).padding()
                        case .result:
                            Button {
                                isResponsePresented = true
                            } label: {
                                Text(chatGPT.chatResults.count.description)
                            }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
                        }
                    }
                })
                .toolbarBackground(.hidden, for: .navigationBar)
                .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    SubmapView()
}
