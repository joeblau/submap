// EKReminder+.swift
// Copyright (c) 2025 Submap

import EventKit
import SwiftUI

extension Array where Element: EKReminder {
    var dataList: [[String: String]] {
        map { $0.data }
    }

    var prompt: String {
        """
        # My Reminders
        \(map { $0.prompt })
        """
    }
}

extension EKReminder: Structurable {
    var data: [String: String] {
        var reminderInfo: [String: String] = .init()

        reminderInfo["Calendar"] = calendar.prompt
        reminderInfo["Title"] = title
        location.map { reminderInfo["Location"] = $0 }
        creationDate.map { reminderInfo["Creation Date"] = $0.formatted() }
        lastModifiedDate.map { reminderInfo["Last Modified Date"] = $0.formatted() }
        timeZone.map { reminderInfo["Time Zone"] = $0.description }
        url.map { reminderInfo["URL"] = $0.absoluteString }
        notes.map { reminderInfo["Notes"] = $0.description }
        attendees.map { reminderInfo["Attendees"] = $0.description }

        return reminderInfo
    }

    var prompt: String {
        """
        ## Reminder
        \(data.renderedAsFacts)
        """
    }
}
