// ChatGPT.swift
// Copyright (c) 2024 Submap

import CoreLocation
import OpenAI
import SwiftUI

@Observable class ChatGPT {
    let openAI: OpenAI = .init(configuration: .init(token: "", host: "localhost", port: 8787, scheme: "http"))

//    func prompt(placemark: CLPlacemark?,
//                location: CLLocation) async throws
//    {
    func prompt() {
        Task {
            do {
                //        let promptText =
                //            """
                //            \(Prompt.prefix(desire: ""))
                //
                //            \(placemark?.prompt ?? "")
                //
                //            \(location.prompt)
                //
                //            \(Prompt.suffix())
                //            """
                //
                //        print(promptText)

                let query = ChatQuery(messages: [
                    .init(role: .user, content: "what is 1 + 1")!,
                ],
                model: .gpt4_o)

                let result = try await openAI.chats(query: query)
                print(result)
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
