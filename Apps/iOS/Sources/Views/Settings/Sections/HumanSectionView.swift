// HumanSectionView.swift
// Copyright (c) 2025 Submap

import SwiftUI

struct HumanSectionView: View {
    @Environment(\.location) var location
    @Environment(\.contacts) var contacts
    @Environment(\.events) var events

    @State private var isContactPickerPresented: Bool = false

    var body: some View {
        @Bindable var location = location
        @Bindable var contacts = contacts
        @Bindable var events = events

        Section {
            LabeledContent {
                Button { isContactPickerPresented = true } label: {
                    switch contacts.selected {
                    case let .some(selected): Text(selected.fullName)
                    case .none: Text("Find your contact")
                    }
                }
            } label: {
                Label("Contact", systemImage: "person.text.rectangle.fill")
                    .labelStyle(SettingLabelStyle(fill: Color.blue.gradient))
            }
            Toggle(isOn: $location.isOn, label: {
                Label("Location", systemImage: "location.fill")
                    .labelStyle(SettingLabelStyle(fill: Color.cyan.gradient))
            })
//            Toggle(isOn: $motionActivity, label: {
//                Label("Motion Activity", systemImage: "figure.walk.motion")
//                    .labelStyle(SettingLabelStyle(fill: Color.teal.gradient))
//            }).disabled(true)
//            Toggle(isOn: $health, label: {
//                Label("Health", systemImage: "heart.fill")
//                    .labelStyle(SettingLabelStyle(fill: Color.mint.gradient))
//            }).disabled(true)
            Toggle(isOn: $events.isCalendarOn, label: {
                Label("Calendar", systemImage: "calendar")
                    .labelStyle(SettingLabelStyle(fill: Color.mint.gradient))
            })
            Toggle(isOn: $events.isReminderOn, label: {
                Label("Reminders", systemImage: "checklist")
                    .labelStyle(SettingLabelStyle(fill: Color.mint.gradient))
            })
        } header: {
            Label("Human", systemImage: "figure.arms.open")
        }
        .onChange(of: location.isOn) { _, newValue in
            guard newValue == true else { return }
            location.requestAccess()
        }
        .onChange(of: events.isCalendarOn) { _, newValue in
            guard newValue == true else { return }
            events.requestEventAccess()
        }
        .onChange(of: events.isReminderOn) { _, newValue in
            guard newValue == true else { return }
            events.requestReminderAccess()
        }
        .sheet(isPresented: $isContactPickerPresented) {
            ContactPicker(selectedContact: $contacts.selected)
        }
    }
}

#Preview {
    HumanSectionView()
}
