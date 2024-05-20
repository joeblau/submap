// OpenAI.swift
// Copyright (c) 2024 Submap

import CoreLocation
import SwiftUI

@Observable class OpenAI {
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
