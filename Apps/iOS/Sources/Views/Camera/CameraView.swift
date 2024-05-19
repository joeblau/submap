// CameraView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct CameraView: View {
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
    }
}

#Preview {
    CameraView()
}
