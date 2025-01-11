// Tesla.swift
// Copyright (c) 2025 Submap

import SwiftUI

@Observable class Tesla: NSObject {}

struct TeslaKey: EnvironmentKey {
    static let defaultValue: Tesla = .init()
}

extension EnvironmentValues {
    var tesla: Tesla {
        get { self[TeslaKey.self] }
        set { self[TeslaKey.self] = newValue }
    }
}
