// Date+.swift
// Copyright (c) 2024 Submap

import Foundation

extension Date: Structurable {
    var data: [String: String] {
        [
            "Date": Date().formatted(date: .long, time: .omitted),
            "Time": Date().formatted(date: .omitted, time: .complete),
        ]
    }

    var prompt: String {
        """
        # Date and Time
        \(data.renderedAsFacts)
        """
    }
}
