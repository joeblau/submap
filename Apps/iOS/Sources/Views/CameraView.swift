// CameraView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct CameraView: View {
    @Environment(\.camera) private var camera

    @State private var viewfinderImage: Image?

    var body: some View {
        ZStack {
            Rectangle().fill(.black)
            ScrollView {
                if let image = viewfinderImage {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height - 300)
                        .fixedSize()
                }
            }
            .disabled(true)
        }
        .ignoresSafeArea(.all)
        .task {
            guard camera.isAuthorized() else { return }
            await camera.start()
            let imageStream = camera.previewStream().map { $0.image }
            for await image in imageStream {
                Task { @MainActor in
                    viewfinderImage = image
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
