// String+.swift
// Copyright (c) 2024 Submap

import Foundation

extension String {
    func stripCodeBlock() -> String {
        components(separatedBy: .newlines)
            .filter { !$0.trimmingCharacters(in: CharacterSet.whitespaces).hasPrefix("```") }
            .joined(separator: "\n")
    }
}
