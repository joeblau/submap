// MapView.swift
// Copyright (c) 2024 Submap

import MapKit
import SwiftUI

struct MapView: View {
    @Environment(\.location) private var location

    @State var isWeatherPresented: Bool = false
    @State var canZoom = false
    @State var position: MapCameraPosition = .camera(MapCamera(centerCoordinate: .init(),
                                                               distance: 100_000_000))
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $position)
                .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: .excludingAll))
                .mapControlVisibility(.hidden)
            HStack(alignment: .top) {
                VStack {
                    HumanView()
                    DeviceView()
                    NetworkView()
                }
                Spacer()
                VStack {
                    Button {} label: {
                        Image(systemName: "scope")
                    }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
                }
            }.padding()
        }
        .frame(height: 300)
        .task {
            try? await Task.sleep(nanoseconds: UInt64(2.0 * 1_000_000_000))
            canZoom = true
            updateView()
        }
        .onChange(of: location.currentLocation) { _, newValue in
            guard newValue != .init(), canZoom else { return }
            updateView()
        }
    }

    func updateView() {
        withAnimation {
            position = .camera(MapCamera(centerCoordinate: location.currentLocation.coordinate,
                                         distance: 1000))
        }
    }
}

#Preview {
    MapView()
}
