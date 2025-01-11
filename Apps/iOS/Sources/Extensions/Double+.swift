// Double+.swift
// Copyright (c) 2025 Submap

import Foundation

extension Double {
    func toPercent() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
