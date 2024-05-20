// Date+.swift
// Copyright (c) 2024 Submap

import Foundation

extension Calendar: Structurable {
    var data: [String: String] {
        let components = dateComponents(
            [.calendar, .timeZone, .era, .year, .month, .day, .hour, .minute, .second, .nanosecond, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear],
            from: Date()
        )

        var dateComponents: [String: String] = [:]

        components.calendar.map {
            $0.locale.map { dateComponents["Locale"] = $0.identifier }
            dateComponents["First Weekday"] = $0.firstWeekday.description
            dateComponents["Minimum Days In First Week"] = $0.minimumDaysInFirstWeek.description
            dateComponents["AM Symbol"] = $0.amSymbol
            dateComponents["PM Symbol"] = $0.pmSymbol
        }
        components.timeZone.map { dateComponents["Time Zone"] = $0.identifier }
        components.era.map { dateComponents["Era"] = $0.description }
        components.year.map { dateComponents["Year"] = $0.description }
        components.month.map { dateComponents["Month"] = $0.description }
        components.day.map { dateComponents["Day"] = $0.description }
        components.hour.map { dateComponents["Hour"] = $0.description }
        components.minute.map { dateComponents["Minute"] = $0.description }
        components.second.map { dateComponents["Second"] = $0.description }
        components.nanosecond.map { dateComponents["Nanosecond"] = $0.description }
        components.weekday.map { dateComponents["Weekday"] = $0.description }
        components.weekdayOrdinal.map { dateComponents["Weekday Ordinal"] = $0.description }
        components.quarter.map { dateComponents["Quarter"] = $0.description }
        components.weekOfMonth.map { dateComponents["Week of Month"] = $0.description }
        components.weekOfYear.map { dateComponents["Week of Year"] = $0.description }
        components.yearForWeekOfYear.map { dateComponents["Year for Week of Year"] = $0.description }

        return dateComponents
    }

    var prompt: String {
        """
        # Calendar
        \(data.renderedAsFacts)
        """
    }
}


extension Calendar.Identifier: CustomStringConvertible {
    public var description: String {
        switch self {
        case .gregorian: "Gregorian"
        case .buddhist: "Buddhist"
        case .chinese: "Chinese"
        case .coptic: "Coptic"
        case .ethiopicAmeteMihret: "Ethiopic Amete Mihret"
        case .ethiopicAmeteAlem: "Ethiopic Amete Alem"
        case .hebrew: "Hebrew"
        case .iso8601: "ISO 8601"
        case .indian: "Indian"
        case .islamic: "Islamic"
        case .islamicCivil: "Islamic Civil"
        case .japanese: "Japanese"
        case .persian: "Persian"
        case .republicOfChina: "Republic of China"
        case .islamicTabular: "Islamic Tabular"
        case .islamicUmmAlQura: "Islamic Umm al-Qura"
        @unknown default: "Unknown Calendar Identifier"
        }
    }
}
