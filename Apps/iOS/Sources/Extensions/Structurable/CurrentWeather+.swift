// CurrentWeather+.swift
// Copyright (c) 2024 Submap

import Foundation
import WeatherKit

extension CurrentWeather: Structurable {
    var data: [String: String] {
        var weatherInfo: [String: String] = .init()

        weatherInfo["Apparent Temperature"] = apparentTemperature.description
        weatherInfo["Dew Point"] = dewPoint.description
        weatherInfo["Humidity"] = humidity.description
        weatherInfo["Temperature"] = temperature.description
        weatherInfo["Air Pressure"] = pressure.description
        weatherInfo["Pressure Trend"] = pressureTrend.description
        weatherInfo["Wind Direction"] = wind.direction.description
        weatherInfo["Wind Gust"] = wind.gust?.description
        weatherInfo["Wind Speed"] = wind.speed.description
        weatherInfo["Cloud Cover"] = cloudCover.description
        weatherInfo["Weather Condition"] = condition.description
        weatherInfo["Is Daylight?"] = isDaylight.description
        weatherInfo["UV Index"] = uvIndex.category.description
        weatherInfo["Weather Visiblity"] = visibility.description
        weatherInfo["Precipitation Intensity"] = precipitationIntensity.description

        return weatherInfo
    }

    var prompt: String {
        """
        # My Contact Information
        \(data.renderedAsFacts)
        """
    }
}
