// CNPostalAddress+.swift
// Copyright (c) 2025 Submap

import Contacts
import Foundation

extension CNPostalAddress {
    func formattedAddress() -> String {
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: self)
    }
}
