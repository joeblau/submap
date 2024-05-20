// EKParticipant+.swift
// Copyright (c) 2024 Submap

import EventKit
import SwiftUI

extension EKParticipant: Structurable {
    var data: [String: String] {
        var participantInfo: [String: String] = .init()

        participantInfo["Is Current User"] = isCurrentUser.description
        name.map { participantInfo["Name"] = $0 }
        participantInfo["Participant Role"] = participantRole.description
        participantInfo["Participant Status"] = participantStatus.description
        participantInfo["Participant Type"] = participantType.description
        participantInfo["URL"] = url.absoluteString
        participantInfo["Contact Predicate"] = contactPredicate.predicateFormat

        return participantInfo
    }

    var prompt: String {
        """
        ## Participant
        \(data.renderedAsFacts)
        """
    }
}

// MARK: - Helpers

extension EKParticipantRole: CustomStringConvertible {
    public var description: String {
        switch self {
        case .chair: "Chair"
        case .nonParticipant: "Non Participant"
        case .optional: "Optional"
        case .required: "Required"
        case .unknown: "Unknown"
        @unknown default: "Unknown"
        }
    }
}

extension EKParticipantStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown: "Unknown"
        case .pending: "Pending"
        case .accepted: "Accepted"
        case .declined: "Declined"
        case .tentative: "Tentative"
        case .delegated: "Delegated"
        case .completed: "Completed"
        case .inProcess: "In Process"
        @unknown default: "Unknown"
        }
    }
}

extension EKParticipantType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown: "Unknown"
        case .person: "Person"
        case .room: "Room"
        case .resource: "Resource"
        case .group: "Group"
        @unknown default: "Unknown"
        }
    }
}
