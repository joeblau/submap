// ComputeState.swift
// Copyright (c) 2025 Submap

import Foundation

enum ComputeState: Identifiable {
    var id: Self { self }
    case idle
    case thinking
    case error
    case result
}
