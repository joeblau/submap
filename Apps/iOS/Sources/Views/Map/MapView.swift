// MapView.swift
// Copyright (c) 2024 Submap

import MapKit
import SwiftUI

struct MapView: View {
    @State var position: MapCameraPosition = .camera(MapCamera(centerCoordinate: .init(),
                                                               distance: 100_000_000))
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $position)
                .mapStyle(.hybrid(elevation: .realistic, pointsOfInterest: .excludingAll))
                .mapControlVisibility(.hidden)
            HStack(alignment: .top) {
                VStack {
                    Button {} label: {
                        Image(systemName: "figure.arms.open")
                    }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
                    
                    Button {} label: {
                        Image(systemName: "iphone")
                    }.buttonStyle(MaterialButtonStyle(active: .constant(false)))

                    Button {} label: {
                        Image(systemName: "network")
                    }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
                    
                    Button {} label: {
                        Image(systemName: "cloud.sun")
                    }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
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
    }
}

#Preview {
    MapView()
}
