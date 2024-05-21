// ChatGPT.swift
// Copyright (c) 2024 Submap

import CoreLocation
import OpenAI
import SwiftDotenv
import SwiftUI

@Observable class ChatGPT: NSObject {
    let openAI: OpenAI

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

    override init() {
        do {
            let path = Bundle.main.path(forResource: ".env", ofType: nil)!
            try Dotenv.configure(atPath: path)
            guard let apiToken = Dotenv.openaiApiKey?.stringValue else {
                fatalError("need to add a .env with an OpenAI key")
            }
            openAI = OpenAI(apiToken: apiToken)
        } catch {
            fatalError("need to add a .env with an OpenAI key")
        }
        super.init()
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
