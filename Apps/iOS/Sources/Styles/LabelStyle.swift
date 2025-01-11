// LabelStyle.swift
// Copyright (c) 2025 Submap

import SwiftUI

struct SettingLabelStyle: LabelStyle {
    let fill: AnyGradient
    let foregroundColor: Color = .white

    func makeBody(configuration: Configuration) -> some View {
        Label(title: {
            configuration.title
        }, icon: {
            configuration.icon
                .frame(width: 36, height: 36)
                .foregroundStyle(.white)
                .background(fill)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 6, style: .continuous))

        })
    }
}

#Preview {
    Label("hello", systemImage: "graduationcap")
        .labelStyle(SettingLabelStyle(fill: Color.indigo.gradient))
}
