// RemoteDeviceView.swift
// Copyright (c) 2025 Submap

import SwiftUI

struct RemoteDeviceView: View {
    @State private var showPopover = false
    @Environment(\.weather) private var weather

    var body: some View {
        Button { self.showPopover = true } label: {
            Image(systemName: "server.rack")
        }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
            .popover(isPresented: $showPopover, arrowEdge: .leading) {
                NavigationStack {
                    List {
                        if let currentWeather = weather.currentWeather {
                            Section("Weather") {
                                ForEach(currentWeather.data.sorted(by: >), id: \.key) { key, value in
                                    LabeledContent(key, value: value)
                                }
                            }
                        }
                    }
                    .headerProminence(.increased)
                    .toolbarTitleDisplayMode(.inlineLarge)
                    .navigationTitle("Remote Devices")
                }
            }
    }
}

#Preview {
    RemoteDeviceView()
}
