// EKEvent+.swift
// Copyright (c) 2024 Submap

import EventKit
import SwiftUI

extension Array where Element: EKEvent {
    var dataList: [[String: String]] {
        map { $0.data }
    }

    var prompt: String {
        """
        # My Events
        \(map { $0.prompt })
        """
    }
}

extension EKEvent: Structurable {
    var data: [String: String] {
        var eventInfo: [String: String] = .init()

        eventInfo["Title"] = title
        eventInfo["Description"] = description

        attendees.map { $0 }?.enumerated().forEach { index, parcicipant in
            eventInfo["Participant Name: \(index)"] = parcicipant.name
            eventInfo["Participant URL: \(index)"] = parcicipant.url.absoluteString
        }

        eventInfo["Event Identifier"] = eventIdentifier
        eventInfo["Event Availiblity"] = availability.description
        eventInfo["Start Date"] = startDate.formatted()
        eventInfo["End Date"] = endDate.formatted()
        eventInfo["Is All Day"] = isAllDay.description
        eventInfo["Occurrence Date"] = occurrenceDate.formatted()
        eventInfo["Is Detached"] = isDetached.description
        organizer.map { eventInfo["Organizer"] = $0.prompt }
        eventInfo["Status"] = status.description
        birthdayContactIdentifier.map { eventInfo["Birthday Contact Identifier"] = $0 }
        structuredLocation.map { eventInfo["Strucutred Location"] = $0.prompt }
        return eventInfo
    }

    var prompt: String {
        """
        ## Event
        \(data.renderedAsFacts)
        """
    }
}

extension EKEventAvailability: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notSupported: "Not Supported"
        case .busy: "Busy"
        case .free: "Free"
        case .tentative: "Tentative"
        case .unavailable: "Unavailable"
        @unknown default: "Unknown Availability"
        }
    }
}

extension EKEventStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: "No Status"
        case .confirmed: "Confirmed"
        case .tentative: "Tentative"
        case .canceled: "Canceled"
        @unknown default: "Unknown Status"
        }
    }
}
