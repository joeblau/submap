// Events.swift
// Copyright (c) 2025 Submap

import EventKit
import SwiftUI

@Observable class Events: NSObject {
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
    var calendarEvents: [EKEvent] = .init()
    var reminders: [EKReminder] = .init()

    override init() {
        super.init()

        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined, .restricted, .denied: print("no calendar access")
        case .fullAccess, .writeOnly: loadCalendars()
        @unknown default: print("no calendar access")
        }

        switch EKEventStore.authorizationStatus(for: .reminder) {
        case .notDetermined, .restricted, .denied: print("no reminder access")
        case .fullAccess, .writeOnly: loadReminders()
        @unknown default: print("no reminder access")
        }
    }

    func requestEventAccess() {
        eventStore.requestFullAccessToEvents { granted, _ in
            switch granted {
            case true:
                self.loadCalendars()
            case false:
                self.isCalendarOn = false
                print("no calendar access")
            }
        }
    }

    func requestReminderAccess() {
        eventStore.requestFullAccessToReminders { granted, _ in
            switch granted {
            case true: self.loadReminders()
            case false: print("no access")
            }
        }
    }

    func loadCalendars() {
        calendars = eventStore.calendars(for: .event)

        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)

        guard let endDate else { return }

        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)

        calendarEvents = eventStore.events(matching: predicate)
    }

    func loadReminders() {
        let remindersPredicate = eventStore.predicateForReminders(in: nil)
        eventStore.fetchReminders(matching: remindersPredicate) { reminders in
            switch reminders {
            case let .some(reminders): self.reminders = reminders
            case .none: print("no reminders")
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
