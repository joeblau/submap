// EKCalendar+.swift
// Copyright (c) 2025 Submap

import EventKit
import SwiftUI

extension Array where Element: EKCalendar {
    var dataList: [[String: String]] {
        map { $0.data }
    }

    var prompt: String {
        """
        # My Calendars
        \(map { $0.prompt })
        """
    }
}

extension EKCalendar: Structurable {
    var data: [String: String] {
        [
            "Title": title,
            "Type": type.description,
            "Is Subscribed": isSubscribed.description,
            "Allows Mofifications": allowsContentModifications.description,
            "Is Immutalbe": isImmutable.description,
            "Calendar Indentifier": calendarIdentifier,
        ]
    }

    var prompt: String {
        """
        ## Calendar
        \(data.renderedAsFacts)
        """
    }
}

extension EKCalendarType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .birthday: "Birthday"
        case .local: "Local"
        case .calDAV: "CalDAV or iCloud"
        case .exchange: "Exchange"
        case .subscription: "Locally Subscribed"
        default: "Unknown"
        }
    }
}
