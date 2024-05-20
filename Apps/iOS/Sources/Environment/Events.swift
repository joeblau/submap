// Events.swift
// Copyright (c) 2024 Submap

import EventKit
import SwiftUI

@Observable class Events {
    static var SETTING_EVENTS_CALENDAR = "setting-events-calendar"
    static var SETTING_EVENTS_REMINDER = "setting-events-reminder"
    var isCalendarOn: Bool = UserDefaults.standard.bool(forKey: Events.SETTING_EVENTS_CALENDAR) {
        didSet {
            UserDefaults.standard.setValue(isCalendarOn, forKey: Events.SETTING_EVENTS_CALENDAR)
        }
    }

    var isReminderOn: Bool = UserDefaults.standard.bool(forKey: Events.SETTING_EVENTS_REMINDER) {
        didSet {
            UserDefaults.standard.setValue(isReminderOn, forKey: Events.SETTING_EVENTS_REMINDER)
        }
    }

    let eventStore = EKEventStore()
    var calendars: [EKCalendar] = .init()
    var reminders: [EKReminder] = .init()

    func requestEventAccess() {
        eventStore.requestFullAccessToEvents { granted, _ in
            switch granted {
            case true:
                self.calendars = self.eventStore.calendars(for: .event)
            case false:
                self.isCalendarOn = false
                print("no calendar access")
            }
        }
    }

    func requestReminderAccess() {
        eventStore.requestFullAccessToReminders { granted, _ in
            switch granted {
            case true:
                let remindersPredicate = self.eventStore.predicateForReminders(in: nil)
                self.eventStore.fetchReminders(matching: remindersPredicate) { reminders in
                    switch reminders {
                    case let .some(reminders): self.reminders = reminders
                    case .none:
                        self.isReminderOn = false
                        print("no reminder access")
                    }
                }
            case false: print("no access")
            }
        }
    }
}

struct EventsKey: EnvironmentKey {
    static let defaultValue: Events = .init()
}

extension EnvironmentValues {
    var events: Events {
        get { self[EventsKey.self] }
        set { self[EventsKey.self] = newValue }
    }
}
