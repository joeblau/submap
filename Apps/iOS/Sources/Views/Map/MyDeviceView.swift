// MyDeviceView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct MyDeviceView: View {
    @State private var showPopover = false
    @Environment(\.device) var device

    var body: some View {
        Button { self.showPopover = true } label: {
            Image(systemName: "macbook.and.iphone")
        }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
            .popover(isPresented: $showPopover, arrowEdge: .leading) {
                NavigationStack {
                    List {
                        Section("Device") {
                            ForEach(UIDevice.current.data.sorted(by: <), id: \.key) { key, value in
                                LabeledContent(key, value: value)
                            }
                        }
                        Section("Calendar") {
                            ForEach(Calendar.current.data.sorted(by: <), id: \.key) { key, value in
                                LabeledContent(key, value: value)
                            }
                        }
                    }
                    .headerProminence(.increased)
                    .toolbarTitleDisplayMode(.inlineLarge)
                    .navigationTitle("My Devices")
                }
            }
    }
}

#Preview {
    MyDeviceView()
}
