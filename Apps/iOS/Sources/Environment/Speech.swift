// Speech.swift
// Copyright (c) 2025 Submap

import Combine
import Speech
import SwiftUI

@Observable class Speech: NSObject {
    static var SETTING_SPEECH = "setting-speech"
    var isOn: Bool = UserDefaults.standard.bool(forKey: Speech.SETTING_SPEECH) {
        didSet {
            UserDefaults.standard.setValue(isOn, forKey: Speech.SETTING_SPEECH)
        }
    }

    let transcriptionSubject = PassthroughSubject<String, Never>()

    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:

                    print("Speech recognition authorized")
                case .denied:
                    print("Speech recognition authorization denied")
                case .restricted:
                    print("Speech recognition restricted")
                case .notDetermined:
                    print("Speech recognition not determined")
                @unknown default:
                    fatalError("Unknown authorization status")
                }
            }
        }
    }

    func recognizeSpeech(url: URL) {
        guard let recognizer = SFSpeechRecognizer() else {
            print("Speech recognizer is not available for the current locale")
            return
        }

        if !recognizer.isAvailable {
            print("Speech recognizer is not currently available")
            return
        }

        let request = SFSpeechURLRecognitionRequest(url: url)

        recognizer.recognitionTask(with: request) { result, error in
            if let error = error {
                print("There was an error: \(error)")
                self.transcriptionSubject.send("")
            } else if let result = result {
                self.transcriptionSubject.send(result.bestTranscription.formattedString)
            }
        }
    }
}

struct SpeechKey: EnvironmentKey {
    static let defaultValue: Speech = .init()
}

extension EnvironmentValues {
    var speech: Speech {
        get { self[SpeechKey.self] }
        set { self[SpeechKey.self] = newValue }
    }
}
