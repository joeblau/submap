// Camera.swift
// Copyright (c) 2024 Submap

import AVFoundation
import CoreImage
import os.log
import SwiftUI
import UIKit

@Observable final class Camera: NSObject {
    static var SETTING_CAMERA = "setting-camera"
    var isOn: Bool = UserDefaults.standard.bool(forKey: Camera.SETTING_CAMERA) {
        didSet {
            UserDefaults.standard.setValue(isOn, forKey: Camera.SETTING_CAMERA)
        }
    }

    private let captureSession = AVCaptureSession()
    private var isCaptureSessionConfigured = false
    private var deviceInput: AVCaptureDeviceInput?
    private var photoOutput: AVCapturePhotoOutput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var sessionQueue: DispatchQueue!

    private var allCaptureDevices: [AVCaptureDevice] {
        AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInTrueDepthCamera, .builtInDualCamera, .builtInDualWideCamera, .builtInWideAngleCamera, .builtInDualWideCamera], mediaType: .video, position: .unspecified).devices
    }

    private var frontCaptureDevices: [AVCaptureDevice] {
        allCaptureDevices
            .filter { $0.position == .front }
    }

    private var backCaptureDevices: [AVCaptureDevice] {
        allCaptureDevices
            .filter { $0.position == .back }
    }

    private var captureDevices: [AVCaptureDevice] {
        var devices = [AVCaptureDevice]()
        #if os(macOS) || (os(iOS) && targetEnvironment(macCatalyst))
            devices += allCaptureDevices
        #else
            if let backDevice = backCaptureDevices.first {
                devices += [backDevice]
            }
            if let frontDevice = frontCaptureDevices.first {
                devices += [frontDevice]
            }
        #endif
        return devices
    }

    private var availableCaptureDevices: [AVCaptureDevice] {
        captureDevices
            .filter { $0.isConnected }
            .filter { !$0.isSuspended }
    }

    private var captureDevice: AVCaptureDevice? {
        didSet {
            guard let captureDevice = captureDevice else { return }
//            logger.debug("Using capture device: \(captureDevice.localizedName)")
            sessionQueue.async {
                self.updateSessionForCaptureDevice(captureDevice)
            }
        }
    }

    var isRunning: Bool {
        captureSession.isRunning
    }

    var isUsingFrontCaptureDevice: Bool {
        guard let captureDevice = captureDevice else { return false }
        return frontCaptureDevices.contains(captureDevice)
    }

    var isUsingBackCaptureDevice: Bool {
        guard let captureDevice = captureDevice else { return false }
        return backCaptureDevices.contains(captureDevice)
    }

    private var addToPhotoStream: ((Data) -> Void)?

    private var addToPreviewStream: ((CIImage) -> Void)?

    var isPreviewPaused = false

    func previewStream() -> AsyncStream<CIImage> {
        AsyncStream { continuation in
            addToPreviewStream = { ciImage in
                if !self.isPreviewPaused {
                    continuation.yield(ciImage)
                }
            }
        }
    }

    func photoStream() -> AsyncStream<Data> {
        AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
            addToPhotoStream = { photo in
                continuation.yield(photo)
            }
        }
    }

    override init() {
        super.init()
        initialize()
    }

    private func initialize() {
        sessionQueue = DispatchQueue(label: "session queue")

        captureDevice = availableCaptureDevices.first ?? AVCaptureDevice.default(for: .video)

//        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
//        NotificationCenter.default.addObserver(self, selector: #selector(updateForDeviceOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    private func configureCaptureSession(completionHandler: (_ success: Bool) -> Void) {
        var success = false

        captureSession.beginConfiguration()
        captureSession.automaticallyConfiguresApplicationAudioSession = false
        defer {
            self.captureSession.commitConfiguration()
            completionHandler(success)
        }

        guard
            let captureDevice = captureDevice,
            let deviceInput = try? AVCaptureDeviceInput(device: captureDevice)
        else {
            logger.error("Failed to obtain video input.")
            return
        }

        let photoOutput = AVCapturePhotoOutput()

        captureSession.sessionPreset = AVCaptureSession.Preset.photo

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoDataOutputQueue"))

        guard captureSession.canAddInput(deviceInput) else {
            logger.error("Unable to add device input to capture session.")
            return
        }
        guard captureSession.canAddOutput(photoOutput) else {
            logger.error("Unable to add photo output to capture session.")
            return
        }
        guard captureSession.canAddOutput(videoOutput) else {
            logger.error("Unable to add video output to capture session.")
            return
        }

        captureSession.addInput(deviceInput)
        captureSession.addOutput(photoOutput)
        captureSession.addOutput(videoOutput)

        self.deviceInput = deviceInput
        self.photoOutput = photoOutput
        self.videoOutput = videoOutput

//        photoOutput.isHighResolutionCaptureEnabled = true
        photoOutput.maxPhotoQualityPrioritization = .speed

        updateVideoOutputConnection()

        isCaptureSessionConfigured = true

        success = true
    }

    func isAuthorized() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: return true
        case .notDetermined: return false
        case .denied: return false
        case .restricted: return false
        @unknown default: return false
        }
    }

    func checkAuthorization() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
//            logger.debug("Camera access authorized.")
            return true
        case .notDetermined:
//            logger.debug("Camera access not determined.")
            sessionQueue.suspend()
            let status = await AVCaptureDevice.requestAccess(for: .video)
            sessionQueue.resume()
            return status
        case .denied:
//            logger.debug("Camera access denied.")
            return false
        case .restricted:
//            logger.debug("Camera library access restricted.")
            return false
        @unknown default:
            return false
        }
    }

    private func deviceInputFor(device: AVCaptureDevice?) -> AVCaptureDeviceInput? {
        guard let validDevice = device else { return nil }
        do {
            return try AVCaptureDeviceInput(device: validDevice)
        } catch {
            logger.error("Error getting capture device input: \(error.localizedDescription)")
            return nil
        }
    }

    private func updateSessionForCaptureDevice(_ captureDevice: AVCaptureDevice) {
        guard isCaptureSessionConfigured else { return }

        captureSession.beginConfiguration()
        defer { captureSession.commitConfiguration() }

        for input in captureSession.inputs {
            if let deviceInput = input as? AVCaptureDeviceInput {
                captureSession.removeInput(deviceInput)
            }
        }

        if let deviceInput = deviceInputFor(device: captureDevice) {
            if !captureSession.inputs.contains(deviceInput), captureSession.canAddInput(deviceInput) {
                captureSession.addInput(deviceInput)
            }
        }

        updateVideoOutputConnection()
    }

    private func updateVideoOutputConnection() {
        if let videoOutput = videoOutput, let videoOutputConnection = videoOutput.connection(with: .video) {
            if videoOutputConnection.isVideoMirroringSupported {
                videoOutputConnection.isVideoMirrored = isUsingFrontCaptureDevice
            }
        }
    }

    func start() async {
        let authorized = await checkAuthorization()
        guard authorized else {
            logger.error("Camera access was not authorized.")
            return
        }

        if isCaptureSessionConfigured {
            if !captureSession.isRunning {
                sessionQueue.async { [self] in
                    self.captureSession.startRunning()
                }
            }
            return
        }

        sessionQueue.async { [self] in
            self.configureCaptureSession { success in
                guard success else { return }
                self.captureSession.startRunning()
            }
        }
    }

    func stop() {
        guard isCaptureSessionConfigured else { return }

        if captureSession.isRunning {
            sessionQueue.async {
                self.captureSession.stopRunning()
            }
        }
    }

    func switchCaptureDevice() {
        if let captureDevice = captureDevice, let index = availableCaptureDevices.firstIndex(of: captureDevice) {
            let nextIndex = (index + 1) % availableCaptureDevices.count
            self.captureDevice = availableCaptureDevices[nextIndex]
        } else {
            captureDevice = AVCaptureDevice.default(for: .video)
        }
    }

    private var deviceOrientation: UIDeviceOrientation {
        var orientation = UIDevice.current.orientation
        if orientation == UIDeviceOrientation.unknown {
            orientation = UIScreen.main.orientation
        }
        return orientation
    }

    @objc
    func updateForDeviceOrientation() {
        // TODO: Figure out if we need this for anything.
    }

    func takePhoto() {
        guard let photoOutput = photoOutput else { return }

        sessionQueue.async {
            var photoSettings = AVCapturePhotoSettings()

            if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
            }

            let isFlashAvailable = self.deviceInput?.device.isFlashAvailable ?? false
            photoSettings.flashMode = isFlashAvailable ? .auto : .off
//            photoSettings.isHighResolutionPhotoEnabled = true
            if let previewPhotoPixelFormatType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
                photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPhotoPixelFormatType]
            }
            photoSettings.photoQualityPrioritization = .balanced

            if let photoOutputVideoConnection = photoOutput.connection(with: .video) {
                if photoOutputVideoConnection.isVideoRotationAngleSupported(90) {
                    photoOutputVideoConnection.videoRotationAngle = 90
                }
//                if photoOutputVideoConnection.isVideoOrientationSupported {
//                    photoOutputVideoConnection.videoOrientation = .portrait
//                }
            }

            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            logger.error("Error capturing photo: \(error.localizedDescription)")
            return
        }

        guard let imageData = photo.fileDataRepresentation() else { return }

        addToPhotoStream?(imageData)
    }
}

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = sampleBuffer.imageBuffer else { return }

        if connection.isVideoRotationAngleSupported(90) {
            connection.videoRotationAngle = 90
        }
//        if connection.isVideoOrientationSupported {
//            connection.videoOrientation = .portrait
//        }

        addToPreviewStream?(CIImage(cvPixelBuffer: pixelBuffer))
    }
}

struct CameraKey: EnvironmentKey {
    static let defaultValue: Camera = .init()
}

extension EnvironmentValues {
    var camera: Camera {
        get { self[CameraKey.self] }
        set { self[CameraKey.self] = newValue }
    }
}

private let logger = Logger(subsystem: "com.joeblau.Submap", category: "Camera")
