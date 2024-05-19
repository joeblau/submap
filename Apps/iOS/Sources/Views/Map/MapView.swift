// MapView.swift
// Copyright (c) 2024 Submap

import MapKit
import SwiftUI

struct MapView: View {
    @State var position: MapCameraPosition = .camera(MapCamera(centerCoordinate: .init(),
                                                               distance: 100_000_000))
    var body: some View {
        ZStack {
            Map(position: $position)
                .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: .excludingAll))
                .mapControlVisibility(.hidden)
        }
        .frame(height: 300)
    }
}

#Preview {
    MapView()
}
