// RemoteDevicesSectionView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct RemoteDevicesSectionView: View {
    @Environment(\.settings) var settings

    var body: some View {
        @Bindable var settings = settings

        Section {
            Picker(selection: $settings.mlModel) {
                ForEach(MLModel.allCases) { mlmodel in
                    Text(mlmodel.description).tag(mlmodel)
                }
            } label: {
                Label("LLM", systemImage: "brain.fill")
                    .labelStyle(SettingLabelStyle(fill: Color.indigo.gradient))
            }

//            Button {} label: {
//                LabeledContent {
//                    Text("Tesla")
//                } label: {
//                    Label("Automobile", systemImage: "car.fill")
//                        .labelStyle(SettingLabelStyle(fill: Color.pink.gradient))
//                }
//            }.disabled(true)
//            Button {} label: {
//                LabeledContent {
//                    Text("HomeKit")
//                } label: {
//                    Label("Home", systemImage: "house.fill")
//                        .labelStyle(SettingLabelStyle(fill: Color.purple.gradient))
//                }
//            }.disabled(true)
        } header: {
            Label("Remote Devices", systemImage: "server.rack")
        }
    }
}

#Preview {
    RemoteDevicesSectionView()
}
