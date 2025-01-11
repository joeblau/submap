// Audio.swift
// Copyright (c) 2025 Submap

import AVFoundation
import Combine
import SwiftUI

@Observable class Audio: NSObject {
    static var SETTING_MICROPHONE = "setting-audio"
    var isOn: Bool = UserDefaults.standard.bool(forKey: Audio.SETTING_MICROPHONE) {
        didSet {
            UserDefaults.standard.setValue(isOn, forKey: Audio.SETTING_MICROPHONE)
        }
    }

    let audioURLSubject = PassthroughSubject<URL, Never>()

    let session = AVAudioSession.sharedInstance()

    private var player: AVAudioPlayer?
    private(set) var recorder: AVAudioRecorder? = nil

    private(set) var state = AudioControllerState.stopped

    private var isStereoSupported = false {
        didSet {
            setupRecorder()
        }
    }

    override init() {
        super.init()
        if isAuthorized() {
            setupRecorder()
            enableBuiltInMic()
        }
    }

    func isAuthorized() -> Bool {
        switch AVAudioApplication.shared.recordPermission {
        case .granted: return true
        case .undetermined, .denied: return false
        @unknown default: return false
        }
    }

    func requestPersmissions() {
        AVAudioApplication.requestRecordPermission { success in
            self.isOn = success
        }
    }

    // MARK: - Audio Session Configuration

    private func enableBuiltInMic() {
        // Find the built-in microphone input.
        guard let availableInputs = session.availableInputs,
              let builtInMicInput = availableInputs.first(where: { $0.portType == .builtInMic })
        else {
            print("The device must have a built-in microphone.")
            return
        }

        // Make the built-in microphone input the preferred input.
        do {
            try session.setPreferredInput(builtInMicInput)
        } catch {
            print("Unable to set the built-in mic as the preferred input.")
        }
    }

    // MARK: - Audio Recording and Playback

    private func setupRecorder() {
        let tempDir = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = tempDir.appendingPathComponent("submap.m4a")

        do {
            try session.setCategory(.playAndRecord, options: [.mixWithOthers, .defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 48000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            ]

            recorder = try AVAudioRecorder(url: fileURL, settings: settings)
            recorder?.delegate = self
            recorder?.prepareToRecord()
        } catch {
            print("Unable to create audio recorder: \(error.localizedDescription)")
        }
    }

    @discardableResult
    func record() -> Bool {
        guard let started = recorder?.record() else { return false }
        state = .recording
        return started
    }

    // Stops recording and calls the completion callback when the recording finishes.
    func stopRecording() {
        recorder?.stop()
        state = .stopped
    }

    func play(audioURL: URL?) {
        guard let url = audioURL else { print("No recording to play"); return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        player?.play()
        state = .playing
    }

    func stopPlayback() {
        player?.stop()
        state = .stopped
    }
}

struct AudioKey: EnvironmentKey {
    static let defaultValue: Audio = .init()
}

extension EnvironmentValues {
    var audio: Audio {
        get { self[AudioKey.self] }
        set { self[AudioKey.self] = newValue }
    }
}

// MARK: - Delegate Extensions

extension Audio: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully _: Bool) {
        let url = FileManager.default.urlInDocumentsDirectory(named: "submap.m4a")
        try? FileManager.default.removeItem(at: url)
        try? FileManager.default.copyItem(at: recorder.url, to: url)

        audioURLSubject.send(url)
    }
}

extension Audio: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_: AVAudioPlayer, successfully _: Bool) {}
}
