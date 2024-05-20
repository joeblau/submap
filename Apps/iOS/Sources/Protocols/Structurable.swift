//
//  Structurable.swift
//  Submap
//
//  Created by Joe Blau on 5/19/24.
//

import Foundation

protocol Structurable {
    var data: [String: String] { get }
    var prompt: String { get }
}
