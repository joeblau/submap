// SettingsView.swift
// Copyright (c) 2025 Submap

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                HumanSectionView()
                MyDevicesSectionView()
                RemoteDevicesSectionView()
            }
            .headerProminence(.increased)
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                VStack(spacing: 32) {
                    Text(Image(systemName: "info.circle.fill")).foregroundStyle(.blue.gradient) + Text(" This data is packaged up and sent to ChatGPT to serve you. If you're not comfortable with that, please delete the app.")
                        .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    Button {
                        dismiss()
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
