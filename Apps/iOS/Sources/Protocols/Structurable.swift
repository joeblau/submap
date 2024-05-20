// Structurable.swift
// Copyright (c) 2024 Submap

import Foundation

protocol Structurable {
    var data: [String: String] { get }
    var prompt: String { get }
}
