// Settings.swift
// Copyright (c) 2024 Submap

import SwiftUI

@Observable class Settings {
    static var SETTING_ML_MODEL = "setting-ml-model"
    var mlModel: MLModel = .init(rawValue: UserDefaults.standard.integer(forKey: Settings.SETTING_ML_MODEL)) ?? .llama {
        didSet {
            UserDefaults.standard.setValue(mlModel.rawValue, forKey: Settings.SETTING_ML_MODEL)
        }
    }
}

struct SettingsKey: EnvironmentKey {
    static let defaultValue: Settings = .init()
}

extension EnvironmentValues {
    var settings: Settings {
        get { self[SettingsKey.self] }
        set { self[SettingsKey.self] = newValue }
    }
}
