// AIResponse.swift
// Copyright (c) 2024 Submap

import Foundation

struct AIResponse: Codable {
    var response: String
    var card: AICard?
}

struct AICard: Codable {
    var coord: AICoordinate?
    var list: [AIListItem]?
    var email: AIEmail?
}

struct AICoordinate: Codable {
    var lat: Double
    var lng: Double
}

struct AIListItem: Codable {
    var title: String
    var date: Date
}

struct AIEmail: Codable {
    var from: String
    var to: String
    var subject: String
    var message: String
}
