// MyDevicesSectionView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct MyDevicesSectionView: View {
    @Environment(\.camera) var camera
    @Environment(\.audio) var audio
    @Environment(\.speech) var speech

    var body: some View {
        @Bindable var camera = camera
        @Bindable var audio = audio
        @Bindable var speech = speech

        Section {
            Toggle(isOn: $camera.isOn, label: {
                Label("Camera", systemImage: "camera.fill")
                    .labelStyle(SettingLabelStyle(fill: Color.green.gradient))
            })
            Toggle(isOn: $audio.isOn, label: {
                Label("Audio", systemImage: "mic.fill").labelStyle(SettingLabelStyle(fill: Color.yellow.gradient))
            })
            Toggle(isOn: $speech.isOn, label: {
                Label("Speech", systemImage: "waveform").labelStyle(SettingLabelStyle(fill: Color.yellow.gradient))
            })
//            Toggle(isOn: $appleWatch, label: {
//                Label("Apple Watch", systemImage: "applewatch").labelStyle(SettingLabelStyle(fill: Color.orange.gradient))
//            }).disabled(true)
//            Toggle(isOn: $macbook, label: {
//                Label("Macbook", systemImage: "macbook")
//                    .labelStyle(SettingLabelStyle(fill: Color.red.gradient))
//            }).disabled(true)
        } header: {
            Label("My Devices", systemImage: "macbook.and.iphone")
        }
        .onChange(of: camera.isOn) { _, newValue in
            guard newValue == true else { return }
            Task {
                guard await camera.checkAuthorization() else { return }
                await camera.start()
            }
        }
        .onChange(of: audio.isOn) { _, newValue in
            guard newValue == true else { return }
            audio.requestPersmissions()
        }
        .onChange(of: speech.isOn) { _, newValue in
            guard newValue == true else { return }
            speech.requestAuthorization()
        }
    }
}

#Preview {
    MyDevicesSectionView()
}
