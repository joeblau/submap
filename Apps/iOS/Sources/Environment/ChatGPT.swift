// ChatGPT.swift
// Copyright (c) 2024 Submap

import CoreLocation
import OpenAI
import SwiftUI

@Observable class ChatGPT {
    let decoder = JSONDecoder()
    var chatResults: [ChatResult] = .init()
    var computeState: ComputeState = .idle
    let openAI: OpenAI = .init(configuration: .init(token: "", host: "openai-proxy.api.submap.com"))

    func prompt(prompt: AIPrompt) {
        computeState = .thinking
        decoder.dateDecodingStrategy = .iso8601

        let query = ChatQuery(messages: [
            .init(role: .system, content: prompt.system)!,
            .init(role: .user, content: prompt.user)!,
        ],
        model: .gpt4_o)

        Task {
            do {
                let result = try await openAI.chats(query: query)
                chatResults.append(result)
                computeState = .result
            } catch {
                print(error)
                computeState = .error
            }
        }
    }

    func reset() {
        computeState = .idle
        chatResults.removeAll(keepingCapacity: true)
    }
}

struct ChatGPTKey: EnvironmentKey {
    static let defaultValue: ChatGPT = .init()
}

extension EnvironmentValues {
    var chatGPT: ChatGPT {
        get { self[ChatGPTKey.self] }
        set { self[ChatGPTKey.self] = newValue }
    }
}
