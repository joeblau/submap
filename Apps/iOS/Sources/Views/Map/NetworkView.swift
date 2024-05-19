// NetworkView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct NetworkView: View {
    var body: some View {
        Menu {
            Section("Tesla") {
                Text("69% Battery")
            }
            Divider()
            Section("Weather") {
                Text("54℉ Sunny")
            }
        } label: {
            Image(systemName: "network")
        }
        .buttonStyle(MaterialButtonStyle(active: .constant(false)))
    }
}

#Preview {
    NetworkView()
}
