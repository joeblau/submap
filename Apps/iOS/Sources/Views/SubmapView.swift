// SubmapView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct SubmapView: View {
    @Environment(\.chatGPT) var chatGPT
    @Environment(\.location) var location
    @Environment(\.events) var events
    @Environment(\.camera) var camera

    @FocusState private var keyboardFocused: Bool

    @State var textPrompt: String = ""
    @State private var isResponsePresented: Bool = false
    @State private var isOnboardPresented: Bool = false

    var body: some View {
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
                            Button {
                                chatGPT.prompt(prompt: AIPrompt(user: textPrompt, location: location, events: events))
                                textPrompt = ""
                                keyboardFocused = false
                            } label: {
                                Image(systemName: "brain.fill")
                                    .frame(maxWidth: .infinity)
                            }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
                            Button {
                                withAnimation { keyboardFocused.toggle() }
                            } label: {
                                HStack {
                                    Image(systemName: "keyboard.fill")
                                    Image(systemName: "hand.draw.fill")
                                }
                            }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
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
//                    ToolbarItem(placement: .topBarTrailing) {
//                        ProgressView()
//                    }
                })
                .toolbarBackground(.hidden, for: .navigationBar)
                .ignoresSafeArea(.keyboard)
        }
        .onAppear(perform: {
            if !location.isOn
                || !camera.isOn
            {
                isOnboardPresented = true
            }
            location.start()
        })
        .fullScreenCover(isPresented: $isOnboardPresented, content: {
            SettingsView()
        })
    }
}

#Preview {
    SubmapView()
}
