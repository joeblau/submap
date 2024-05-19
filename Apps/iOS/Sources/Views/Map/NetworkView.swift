// NetworkView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct NetworkView: View {
    var body: some View {
        Menu {
            Section("Tesla") {
                Button("69% Battery", action: {})
            }
            Divider()
            Section("Weather") {
                Button("54℉ Sunny", action: {})
            }
        } label: {
            Image(systemName: "server.rack")
        }
        .buttonStyle(MaterialButtonStyle(active: .constant(false)))
    }
}

#Preview {
    NetworkView()
}
