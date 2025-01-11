// ProgressViewStyle.swift
// Copyright (c) 2025 Submap

import SwiftUI

struct AudioProgressStyle: ProgressViewStyle {
    var clippedShape = RoundedRectangle(cornerRadius: 12, style: .continuous)

    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in
            Rectangle()
                .foregroundStyle(.clear)
                .background(.ultraThinMaterial, in: clippedShape)
                .environment(\.colorScheme, .dark)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(.blue.gradient)
                        .frame(width: geometry.size.width * progress)
                        .padding(1)
                }
                .clipShape(clippedShape)
                .overlay(clippedShape.stroke(.black.gradient, lineWidth: 0.5))
        }
    }
}
