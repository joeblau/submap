// Weather.swift
// Copyright (c) 2025 Submap

import CoreLocation
import SwiftUI
import WeatherKit

@Observable class Weather {
    let service = WeatherService.shared
    var currentWeather: CurrentWeather?

    func weather(for currentLocation: CLLocation) {
        Task {
            do {
                currentWeather = try await service.weather(for: currentLocation,
                                                           including: .current)
            } catch {
                print(error)
            }
        }
    }
}

struct WeatherKey: EnvironmentKey {
    static let defaultValue: Weather = .init()
}

extension EnvironmentValues {
    var weather: Weather {
        get { self[WeatherKey.self] }
        set { self[WeatherKey.self] = newValue }
    }
}
