//
//  OpenAI.swift
//  Submap
//
//  Created by Joe Blau on 5/19/24.
//

import SwiftUI
import CoreLocation

@Observable class OpenAI {
    func prompt(placemark: CLPlacemark?,
                location: CLLocation) async throws {
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
