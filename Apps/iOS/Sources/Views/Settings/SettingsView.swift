// SettingsView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct SettingsView: View {
    @State var location = false
    @State var motionActivity = false
    @State var health = false
    @State var camera = false
    @State var microphone = false
    @State var appleWatch = false
    @State var macbook = false
    @State var automobile = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button {} label: {
                        LabeledContent {
                            Text("Joe Blau")
                        } label: {
                            Label("Contact", systemImage: "person.text.rectangle.fill")
                                .labelStyle(SettingLabelStyle(fill: Color.blue.gradient))
                        }
                    }
                    Toggle(isOn: $location, label: {
                        Label("Location", systemImage: "location.fill")
                            .labelStyle(SettingLabelStyle(fill: Color.cyan.gradient))
                    }).disabled(true)
                    Toggle(isOn: $motionActivity, label: {
                        Label("Motion Activity", systemImage: "figure.walk.motion")
                            .labelStyle(SettingLabelStyle(fill: Color.teal.gradient))
                    }).disabled(true)
                    Toggle(isOn: $health, label: {
                        Label("Health", systemImage: "heart.fill")
                            .labelStyle(SettingLabelStyle(fill: Color.mint.gradient))
                    }).disabled(true)
                } header: {
                    Label("Human", systemImage: "figure.arms.open")
                }

                Section {
                    Toggle(isOn: $camera, label: {
                        Label("Camera", systemImage: "camera.fill")
                            .labelStyle(SettingLabelStyle(fill: Color.green.gradient))
                    }).disabled(true)
                    Toggle(isOn: $microphone, label: {
                        Label("Microphone", systemImage: "mic.fill").labelStyle(SettingLabelStyle(fill: Color.yellow.gradient))
                    }).disabled(true)
                    Toggle(isOn: $appleWatch, label: {
                        Label("Apple Watch", systemImage: "applewatch").labelStyle(SettingLabelStyle(fill: Color.orange.gradient))
                    }).disabled(true)
                    Toggle(isOn: $macbook, label: {
                        Label("Macbook", systemImage: "macbook")
                            .labelStyle(SettingLabelStyle(fill: Color.red.gradient))
                    }).disabled(true)
                } header: {
                    Label("Device", systemImage: "iphone")
                }

                Section {
                    Toggle(isOn: $automobile, label: {
                        Label("Automobile", systemImage: "car.fill")
                            .labelStyle(SettingLabelStyle(fill: Color.pink.gradient))
                    }).disabled(true)
                } header: {
                    Label("Network", systemImage: "network")
                }
            }
            .headerProminence(.increased)
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                VStack(spacing: 32) {
                    Text(Image(systemName: "info.circle.fill")).foregroundStyle(.blue.gradient) + Text(" This data is packaged up and sent to ChatGPT to serve you. If you're not comfortable with that, please delete the app.")
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    Button {
//                        dismiss()
                    } label: {
                        Text("Let's Go").frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent).controlSize(.large)
                }
                .padding()
                .background(.ultraThinMaterial)
            }
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
