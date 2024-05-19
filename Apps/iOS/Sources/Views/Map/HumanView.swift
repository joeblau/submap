// HumanView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct HumanView: View {
    var body: some View {
        Menu {
            Section("Human") {
                Text("Joe Blau")
                Text("Male")
            }
            Section("Location") {
                Text("San Francisco")
                Text("USA")
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
