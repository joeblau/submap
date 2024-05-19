// HumanView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct HumanView: View {
    var body: some View {
        Menu {
            Section("Human") {
                Button("Joe Blau", action: {})
                Button("Male", action: {})
            }
            Section("Location") {
                Button("San Francisco", action: {})
                Button("Califorina", action: {})
                Button("United States", action: {})
            }
        } label: {
            Image(systemName: "figure.arms.open")
        }
        .buttonStyle(MaterialButtonStyle(active: .constant(false)))
    }
}

#Preview {
    HumanView()
}
