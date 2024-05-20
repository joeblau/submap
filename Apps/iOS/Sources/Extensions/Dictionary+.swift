// Dictionary+.swift
// Copyright (c) 2024 Submap

import Foundation

extension Dictionary where Key == String, Value == String {
    var renderedAsFacts: String {
        map { "- \($0.key): \($0.value)" }
            .joined(separator: "\n")
    }
}
