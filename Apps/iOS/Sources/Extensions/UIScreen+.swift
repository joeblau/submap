// UIScreen+.swift
// Copyright (c) 2025 Submap

import UIKit

extension UIScreen {
    var orientation: UIDeviceOrientation {
        let point = coordinateSpace.convert(CGPoint.zero, to: fixedCoordinateSpace)
        if point == CGPoint.zero {
            return .portrait
        } else if point.x != 0 && point.y != 0 {
            return .portraitUpsideDown
        } else if point.x == 0 && point.y != 0 {
            return .landscapeRight // .landscapeLeft
        } else if point.x != 0 && point.y == 0 {
            return .landscapeLeft // .landscapeRight
        } else {
            return .unknown
        }
    }
}
