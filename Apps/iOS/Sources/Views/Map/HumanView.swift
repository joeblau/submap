// HumanView.swift
// Copyright (c) 2024 Submap

import SwiftUI

struct HumanView: View {
    @State private var showPopover = false
    @Environment(\.location) var location
    @Environment(\.contacts) var contacts
    @Environment(\.events) var events

    var body: some View {
        Button { self.showPopover = true } label: {
            Image(systemName: "figure.arms.open")
        }.buttonStyle(MaterialButtonStyle(active: .constant(false)))
            .popover(isPresented: $showPopover, arrowEdge: .leading) {
                NavigationStack {
                    List {
                        if let selectedContact = contacts.selected {
                            Section("Me") {
                                ForEach(selectedContact.data.sorted(by: <), id: \.key) { key, value in
                                    LabeledContent(key, value: value)
                                }
                            }
                        }

                        if let placemark = location.placemark {
                            Section("Placemark") {
                                ForEach(placemark.data.sorted(by: <), id: \.key) { key, value in
                                    LabeledContent(key, value: value)
                                }
                            }
                        }

                        Section("Location") {
                            ForEach(location.currentLocation.data.sorted(by: <), id: \.key) { key, value in
                                LabeledContent(key, value: value)
                            }
                        }

                        Section("Calendars") {
                            ForEach(events.calendars.dataList, id: \.self) { data in
                                Group {
                                    ForEach(data.sorted(by: <), id: \.key) { key, value in
                                        LabeledContent(key, value: value)
                                    }
                                }
                            }
                        }

                        Section("Calendar Events") {
                            ForEach(events.calendarEvents.dataList, id: \.self) { data in
                                Group {
                                    ForEach(data.sorted(by: <), id: \.key) { key, value in
                                        LabeledContent(key, value: value)
                                    }
                                }
                            }
                        }
                        Section("Reminders") {
                            ForEach(events.reminders.dataList, id: \.self) { data in
                                Group {
                                    ForEach(data.sorted(by: <), id: \.key) { key, value in
                                        LabeledContent(key, value: value)
                                    }
                                }
                            }
                        }
                    }
                    .headerProminence(.increased)
                    .toolbarTitleDisplayMode(.inlineLarge)
                    .navigationTitle("Human")
                }
            }
    }
}

#Preview {
    HumanView()
}
