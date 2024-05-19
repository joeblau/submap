// DeviceView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct DeviceView: View {
    var body: some View {
        Menu {
            Section("iPhone") {
                Button("WiFi Enabled", action: {})
            }
            Divider()
            Section("Apple Watch") {
                Button("55 bpm Heart Rate", action: {})
            }
            Divider()
            Section("Mac") {
                Button("Locked", action: {})
            }
        } label: {
            Image(systemName: "macbook.and.iphone")
        }
        .buttonStyle(MaterialButtonStyle(active: .constant(false)))
    }
}

#Preview {
    DeviceView()
}
