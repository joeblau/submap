//
//  UIDevice+.swift
//  Submap
//
//  Created by Joe Blau on 11/12/23.
//

import SwiftUI

extension UIDevice: Structurable {

    var data: [String : String] {
        [
            "Battery Level": Double(UIDevice.current.batteryLevel).toPercent(),
            "Batter State": UIDevice.current.batteryState.description,
            "Model": UIDevice.current.model.description,
            "System Name": UIDevice.current.systemName.description,
            "Version": UIDevice.current.systemVersion.description
        ]
    }
    
    var prompt: String {
        """
        # My Device Information
        \(data.renderedAsFacts)
        """
    }
}

extension UIDevice.BatteryState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:  "Unknown"
        case .unplugged:  "Unplugged"
        case .charging:  "Charging"
        case .full: "Full"
        @unknown default: "Unknown"
        }
    }
}
