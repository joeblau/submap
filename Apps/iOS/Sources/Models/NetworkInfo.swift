//
//  NetworkInfo.swift
//  Submap
//
//  Created by Joe Blau on 5/19/24.
//

import Foundation

struct NetworkInfo {
    var interface: String
    var success: Bool = false
    var ssid: String?
    var bssid: String?
}
