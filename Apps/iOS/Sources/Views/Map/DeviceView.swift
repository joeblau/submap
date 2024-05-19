//
//  DeviceView.swift
//  Submap
//
//  Created by Joe Blau on 5/18/24.
//

import SwiftUI

struct DeviceView: View {
    var body: some View {
        Menu {
            Section("iPhone") {
                Text("Stationary")
            }
            Divider()
            Section("Apple Watch") {
                Text("55 bpm")
            }
            Divider()
            Section("Mac") {
                Text("55 bpm")
            }
        } label: {
            Image(systemName: "iphone")
        }
        .buttonStyle(MaterialButtonStyle(active: .constant(false)))
    }
}

#Preview {
    DeviceView()
}
