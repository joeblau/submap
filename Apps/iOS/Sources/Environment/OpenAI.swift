// OpenAI.swift
// Copyright (c) 2024 Submap

import CoreLocation
import SwiftDotenv
import SwiftUI

@Observable class OpenAI: NSObject {
    func prompt(placemark: CLPlacemark?,
                location: CLLocation) async throws
    {
        let promptText =
            """
            \(Prompt.prefix(desire: ""))

            \(placemark?.prompt ?? "")

            \(location.prompt)

            \(Prompt.suffix())
            """

        print(promptText)
    }

    override init() {
        super.init()
        do {
            let path = Bundle.main.path(forResource: ".env", ofType: nil)!
            try Dotenv.configure(atPath: path)

        } catch {
            fatalError("need to add a .env with an OpenAI key")
        }
    }
}

struct OpenAIKey: EnvironmentKey {
    static let defaultValue: OpenAI = .init()
}

extension EnvironmentValues {
    var openAI: OpenAI {
        get { self[OpenAIKey.self] }
        set { self[OpenAIKey.self] = newValue }
    }
}
