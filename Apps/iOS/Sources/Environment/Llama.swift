// Llama.swift
// Copyright (c) 2025 Submap

import SwiftUI

@Observable class Llama: NSObject {
    func prompt(prompt _: AIPrompt) {}
}

struct LlamaKey: EnvironmentKey {
    static let defaultValue: Llama = .init()
}

extension EnvironmentValues {
    var llama: Llama {
        get { self[LlamaKey.self] }
        set { self[LlamaKey.self] = newValue }
    }
}
