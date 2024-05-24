// RemoteDevicesSectionView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct RemoteDevicesSectionView: View {
    var body: some View {
        Section {
            Button {} label: {
                LabeledContent {
                    Text("Tesla")
                } label: {
                    Label("Automobile", systemImage: "car.fill")
                        .labelStyle(SettingLabelStyle(fill: Color.pink.gradient))
                }
            }.disabled(true)
            Button {} label: {
                LabeledContent {
                    Text("HomeKit")
                } label: {
                    Label("Home", systemImage: "house.fill")
                        .labelStyle(SettingLabelStyle(fill: Color.purple.gradient))
                }
            }.disabled(true)
            Button {} label: {
                LabeledContent {
                    Text("ChatGPT")
                } label: {
                    Label("LLM", systemImage: "brain.fill")
                        .labelStyle(SettingLabelStyle(fill: Color.indigo.gradient))
                }
            }.disabled(true)
        } header: {
            Label("Remote Devices", systemImage: "server.rack")
        }
    }
}

#Preview {
    RemoteDevicesSectionView()
}
