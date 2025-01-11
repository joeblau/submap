// CLLocation+.swift
// Copyright (c) 2025 Submap

import CoreLocation
import Foundation

extension CLLocation: Structurable {
    var data: [String: String] {
        [
            "Altitude": altitude.description,
            "Ellipsoidal Altitude": ellipsoidalAltitude.description,
            "Course": course.description,
            "Course Accuracy": courseAccuracy.description,
            "Speed": speed.description,
            "Speed Accuracy": speedAccuracy.description,
            "Latitude": coordinate.latitude.description,
            "Horizontal Accuracy": horizontalAccuracy.description,
            "Longitude": coordinate.longitude.description,
            "Vertical Accuracy": verticalAccuracy.description,
            "Building Floor": floor?.description ?? "",
        ]
    }

    var prompt: String {
        """
        # My Location
        \(data.renderedAsFacts)
        """
    }
}
