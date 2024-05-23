// ChatGPT.swift
// Copyright (c) 2024 Submap

import CoreLocation
import OpenAI
import SwiftUI

@Observable class ChatGPT {
    let decoder = JSONDecoder()

    let openAI: OpenAI = .init(configuration: .init(token: "", host: "openai-proxy.api.submap.com"))

    func prompt(prompt: AIPrompt) {
        decoder.dateDecodingStrategy = .iso8601

        let query = ChatQuery(messages: [
            .init(role: .system, content: prompt.system)!,
            .init(role: .user, content: prompt.user)!,
        ],
        model: .gpt4_o)

        Task {
            do {
                let result = try await openAI.chats(query: query)
                guard let resultString = result.choices.first?.message.content?.string?.components(separatedBy: .newlines).filter({ !$0.trimmingCharacters(in: CharacterSet.whitespaces).hasPrefix("```") }).joined(separator: "\n"),
                      let resultData = resultString.data(using: .utf8)
                else {
                    return
                }
                let response = try decoder.decode(AIResponse.self, from: resultData)
                print(response)
            } catch {
                print(error)
            }
        }
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
