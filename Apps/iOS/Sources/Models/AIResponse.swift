//
//  AIResponse.swift
//  Submap
//
//  Created by Joe Blau on 5/23/24.
//

import Foundation

struct AIResponse: Codable {
    var response: String
    var card: AICard?
}

struct AICard: Codable {
    var coord: AICoordinate?
    var list: [AIListItem]?
}

struct AICoordinate: Codable {
    var lat: Double
    var lng: Double
}

struct AIListItem: Codable {
    var title: String
    var date: Date
}
