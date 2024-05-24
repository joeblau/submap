// MLModel.swift
// Copyright (c) 2024 Submap

import Foundation

enum MLModel: Int, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    case llama = 0
    case chatGPT = 1

    var description: String {
        switch self {
        case .llama: "llama-3-8b"
        case .chatGPT: "gpt4_0"
        }
    }
}
