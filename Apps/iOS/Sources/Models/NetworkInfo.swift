// NetworkInfo.swift
// Copyright (c) 2024 Submap

import Foundation

struct NetworkInfo {
    var interface: String
    var success: Bool = false
    var ssid: String?
    var bssid: String?
}
