//
//  CLLocation+.swift
//  Submap
//
//  Created by Joe Blau on 11/13/23.
//

import Foundation
import CoreLocation

extension CLLocation: Structurable {
    var data: [String : String] {
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
            "Building Floor": floor?.description ?? ""
        ]
    }
    
    var prompt: String {
        """
        # My Location
        \(data.renderedAsFacts)
        """
    }
}
