// MLModel.swift
// Copyright (c) 2025 Submap

import Foundation

enum MLModel: Int, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    case llama = 0
    case chatGPT = 1

    var description: String {
        switch self {
        case .llama: "llama-3-70b"
        case .chatGPT: "gpt4_0"
        }
    }
}
