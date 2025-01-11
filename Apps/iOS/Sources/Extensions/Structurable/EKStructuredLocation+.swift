// EKStructuredLocation+.swift
// Copyright (c) 2025 Submap

import EventKit

extension EKStructuredLocation: Structurable {
    var data: [String: String] {
        var locationInfo: [String: String] = .init()

        title.map { locationInfo["Title"] = $0 }
        geoLocation.map { locationInfo["Location"] = $0.description }
        locationInfo["Radius"] = "\(radius)"

        return locationInfo
    }

    var prompt: String {
        """
        ## Structured Location
        \(data.renderedAsFacts)
        """
    }
}
