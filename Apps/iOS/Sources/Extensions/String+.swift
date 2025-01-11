// String+.swift
// Copyright (c) 2025 Submap

import Foundation

extension String {
    func stripCodeBlock() -> String {
        components(separatedBy: .newlines)
            .filter { !$0.trimmingCharacters(in: CharacterSet.whitespaces).hasPrefix("```") }
            .joined(separator: "\n")
    }
}
