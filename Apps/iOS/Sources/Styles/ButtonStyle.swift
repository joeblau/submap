// ButtonStyle.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct MaterialButtonStyle: ButtonStyle {
    var shape = RoundedRectangle(cornerRadius: 12, style: .continuous)
    @Environment(\.isEnabled) var isEnabled
    @Binding var active: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .foregroundStyle(.primary)
            .padding(12)
            .frame(minWidth: 48, maxHeight: 48)
            .background { shape.fill(active ? Color.blue.gradient : Color.clear.gradient).animation(.linear(duration: 0.2), value: active) }
            .background(.ultraThinMaterial, in: shape)
            .overlay(shape.stroke(.black.gradient, lineWidth: 0.5))
            .shadow(radius: 4)
            .environment(\.colorScheme, .dark)
            .opacity(configuration.isPressed ? 0.90 : 1)
            .scaleEffect(configuration.isPressed ? 0.90 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .opacity(isEnabled ? 1.0 : 0.6)
    }
}
