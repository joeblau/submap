//
//  Dictionary+.swift
//  Submap
//
//  Created by Joe Blau on 11/12/23.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    var renderedAsFacts: String {
        self.map { "- \($0.key): \($0.value)" }
            .joined(separator: "\n")
    }
}
