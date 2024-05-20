// HumanView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct HumanView: View {
    @State private var showPopover = false
    @Environment(\.location) var location
    @Environment(\.contacts) var contacts

    var body: some View {
        Button { self.showPopover = true } label: {
            Image(systemName: "figure.arms.open")
        }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
            .popover(isPresented: $showPopover, arrowEdge: .leading) {
                NavigationStack {
                    List {
                        if let selectedContact = contacts.selected {
                            Section("Me") {
                                ForEach(selectedContact.data.sorted(by: >), id: \.key) { key, value in
                                    LabeledContent(key, value: value)
                                }
                            }
                        }
                        
                        if let placemark = location.placemark {
                            Section("Placemark") {
                                ForEach(placemark.data.sorted(by: >), id: \.key) { key, value in
                                    LabeledContent(key, value: value)
                                }
                            }
                        }

                        Section("Location") {
                            ForEach(location.currentLocation.data.sorted(by: >), id: \.key) { key, value in
                                LabeledContent(key, value: value)
                            }
                        }
                    }
                }
            }
    }
}

#Preview {
    HumanView()
}
