//
//  Double+.swift
//  Submap
//
//  Created by Joe Blau on 11/12/23.
//

import Foundation

extension Double {
    func toPercent() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
