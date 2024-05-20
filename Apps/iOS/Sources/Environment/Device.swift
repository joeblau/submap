// Device.swift
// Copyright (c) 2024 Submap

import SwiftUI

@Observable class Device: NSObject {
    override init() {
        super.init()
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
}

struct DeviceKey: EnvironmentKey {
    static let defaultValue: Device = .init()
}

extension EnvironmentValues {
    var device: Device {
        get { self[DeviceKey.self] }
        set { self[DeviceKey.self] = newValue }
    }
}
